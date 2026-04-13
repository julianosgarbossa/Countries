//
//  PasswordRecoveryViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 13/04/26.
//

import Foundation

protocol PasswordRecoveryViewModelDelegate: AnyObject {
    func didValidateFieldAndButton(isValid: Bool)
    func didRecoverySuccess()
}

final class PasswordRecoveryViewModel {
    
    weak var delegate: PasswordRecoveryViewModelDelegate?
    
    private var email: String?
    
    func updateFieldAndButton(value: String?) {
        email = value
        delegate?.didValidateFieldAndButton(isValid: InputValidator.validateEmail(text: email))
    }
    
    func passwordRecovery() {
        // Integração futura com camada de serviço (Firebase Auth)
        delegate?.didRecoverySuccess()
    }
}
