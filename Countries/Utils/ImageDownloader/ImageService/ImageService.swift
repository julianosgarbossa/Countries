//
//  ImageService.swift
//  TudoSobreCamadaDeNetworkMasterCode
//
//  Created by Caio Fabrini on 18/04/26.
//

import UIKit

final class ImageService {

  static let shared = ImageService()

  private init() { }

  private let workerQueue = DispatchQueue(label: "ImageService.worker",
                                          qos: .userInitiated,
                                          attributes: .concurrent)


  func download(urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) -> URLSessionDataTask? {

    // Primeiro verificamos se a imagem já existe no cache
    // Se existir, NÃO PRECISAMOS FAZER REQUISIÇÃO NOVAMENTE DA IMAGEM!
    if let cachedImage = ImageCache.shared.get(key: urlString) {
      DispatchQueue.main.async {
        completion(.success(cachedImage))
      }
      return nil
    }

    guard let url = URL(string: urlString) else {
      DispatchQueue.main.async {
        completion(.failure(.invalidURL(url: urlString)))
      }
      return nil
    }

    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let self else { return }
      if let error = error as? URLError {
        if error.code == .cancelled {
          return
        }

        DispatchQueue.main.async {
          completion(.failure(.networkFailure(error)))
        }
        return
      }

      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        DispatchQueue.main.async {
          completion(.failure(.invalidResponse))
        }
        return
      }

      // Aqui usamos uma fila em background para transformar
      // em UIImage, evitando extremo processamento na Main thread
      workerQueue.async {
        guard let data, let image = UIImage(data: data) else {
          completion(.failure(.noData))
          return
        }

        ImageCache.shared.save(image: image, key: urlString)

        DispatchQueue.main.async {
          completion(.success(image))
        }
      }
    }

    task.resume()
    return task
  }
}
