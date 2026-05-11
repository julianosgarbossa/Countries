//
//  APIClient.swift
//  Countries
//

import Foundation

final class APIClient {

    static let shared = APIClient()

    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func request<T: Decodable>(
        _ endpoint: Endpoint,
        expecting type: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = endpoint.url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL(url: endpoint.path)))
            }
            return
        }

        let task = session.dataTask(with: url) { [decoder] data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.networkFailure(error)))
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(.statusCode(code: httpResponse.statusCode)))
                }
                return
            }

            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }

            do {
                let decoded = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}
