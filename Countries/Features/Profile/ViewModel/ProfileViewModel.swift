//
//  ProfileViewModel.swift
//  Countries
//
//  Created by Marcelo Araujo on 15/04/26.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func didLogoutSuccess()
}

final class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    
    func logout() {
        // Integração futura com camada de serviço (Firebase Auth)
        delegate?.didLogoutSuccess()
    }
}
