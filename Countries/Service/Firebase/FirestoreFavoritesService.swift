//
//  FirestoreFavoritesService.swift
//  Countries
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class FirestoreFavoritesService {

    static let shared = FirestoreFavoritesService()
    private let db = Firestore.firestore()
    private init() {}

    private func userDocRef() -> DocumentReference? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return db.collection("users").document(uid)
    }

    func fetchFavorites(completion: @escaping (Result<Set<String>, Error>) -> Void) {
        guard let ref = userDocRef() else {
            completion(.success([]))
            return
        }

        ref.getDocument { snapshot, error in
            if let error {
                completion(.failure(error))
                return
            }

            let ids = snapshot?.data()?["favorites"] as? [String] ?? []
            completion(.success(Set(ids)))
        }
    }

    func saveFavorites(_ ids: Set<String>, completion: ((Error?) -> Void)? = nil) {
        guard let ref = userDocRef() else {
            completion?(nil)
            return
        }

        ref.setData(["favorites": Array(ids).sorted()], merge: true) { error in
            completion?(error)
        }
    }
}
