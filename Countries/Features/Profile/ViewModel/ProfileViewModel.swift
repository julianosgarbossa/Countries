//
//  ProfileViewModel.swift
//  Countries
//
//  Created by Marcelo Araujo on 15/04/26.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func didLogoutSuccess()
    func didDeleteAccountSuccess()
    func didDeleteAccountFailure(message: String)
}

final class ProfileViewModel {

    weak var delegate: ProfileViewModelDelegate?

    var userName: String {
        return "Usuário Countries"
    }

    var userEmail: String {
        return "usuario@countries.com"
    }

    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "Versão \(version) (\(build))"
    }

    func logout() {
        delegate?.didLogoutSuccess()
    }

    func deleteAccount() {
        // Integração futura com camada de serviço (Firebase Auth)
        // Após deletar no backend, limpar dados locais (Keychain, UserDefaults, cache)
        delegate?.didDeleteAccountSuccess()
    }
}
