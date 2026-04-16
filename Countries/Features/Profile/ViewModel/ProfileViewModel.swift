//
//  ProfileViewModel.swift
//  Countries
//
//  Created by Marcelo Araujo on 15/04/26.
//

import Foundation
import FirebaseAuth

protocol ProfileViewModelDelegate: AnyObject {
    func didLogoutSuccess()
    func didLogoutFailure(message: String)
    func didDeleteAccountSuccess()
    func didDeleteAccountFailure(message: String)
    func didChangeLoadingState(isLoading: Bool)
}

final class ProfileViewModel {

    weak var delegate: ProfileViewModelDelegate?

    var userName: String {
        AuthService.shared.currentUser?.displayName ?? "Usuário"
    }

    var userEmail: String {
        AuthService.shared.currentUser?.email ?? ""
    }

    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "Versão \(version) (\(build))"
    }

    func logout() {
        do {
            try AuthService.shared.logout()
            delegate?.didLogoutSuccess()
        } catch {
            delegate?.didLogoutFailure(message: FirebaseErrorMapper.message(for: error))
        }
    }

    func deleteAccount() {
        delegate?.didChangeLoadingState(isLoading: true)

        AuthService.shared.deleteAccount { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.didChangeLoadingState(isLoading: false)
                switch result {
                case .success:
                    self?.delegate?.didDeleteAccountSuccess()
                case .failure(let error):
                    self?.delegate?.didDeleteAccountFailure(message: FirebaseErrorMapper.message(for: error))
                }
            }
        }
    }
}
