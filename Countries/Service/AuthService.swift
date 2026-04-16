//
//  AuthService.swift
//  Countries
//
//  Created by Marcelo Araujo on 15/04/26.
//

import Foundation
import FirebaseAuth

final class AuthService {

    static let shared = AuthService()
    private init() {}

    var currentUser: User? {
        Auth.auth().currentUser
    }

    var isLoggedIn: Bool {
        currentUser != nil
    }

    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(AuthServiceError.unknownError))
                return
            }
            completion(.success(user))
        }
    }

    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else {
                completion(.failure(AuthServiceError.unknownError))
                return
            }
            completion(.success(user))
        }
    }

    func sendPasswordReset(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }

    func logout() throws {
        try Auth.auth().signOut()
    }

    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = currentUser else {
            completion(.failure(AuthServiceError.noCurrentUser))
            return
        }
        user.delete { error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }

    func updateDisplayName(_ name: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let user = currentUser else {
            completion(.failure(AuthServiceError.noCurrentUser))
            return
        }
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.commitChanges { error in
            if let error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }
}

enum AuthServiceError: LocalizedError {
    case unknownError
    case noCurrentUser

    var errorDescription: String? {
        switch self {
        case .unknownError:
            return "Ocorreu um erro inesperado. Tente novamente."
        case .noCurrentUser:
            return "Nenhum usuário autenticado."
        }
    }
}
