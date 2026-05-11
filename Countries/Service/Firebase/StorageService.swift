//
//  StorageService.swift
//  Countries
//

import UIKit
import FirebaseStorage
import FirebaseAuth

final class StorageService {

    static let shared = StorageService()
    private let storage = Storage.storage()
    private init() {}

    func uploadProfilePhoto(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(StorageServiceError.noCurrentUser))
            return
        }

        guard let data = image.jpegData(compressionQuality: 0.75) else {
            completion(.failure(StorageServiceError.imageConversionFailed))
            return
        }

        let ref = storage.reference().child("profile_photos/\(uid).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        ref.putData(data, metadata: metadata) { _, error in
            if let error {
                completion(.failure(error))
                return
            }

            ref.downloadURL { url, error in
                if let error {
                    completion(.failure(error))
                    return
                }

                guard let url else {
                    completion(.failure(StorageServiceError.urlNotFound))
                    return
                }

                completion(.success(url))
            }
        }
    }
}

enum StorageServiceError: LocalizedError {
    case noCurrentUser
    case imageConversionFailed
    case urlNotFound

    var errorDescription: String? {
        switch self {
        case .noCurrentUser:
            return "Nenhum usuário autenticado."
        case .imageConversionFailed:
            return "Não foi possível converter a imagem."
        case .urlNotFound:
            return "URL da imagem não encontrada."
        }
    }
}
