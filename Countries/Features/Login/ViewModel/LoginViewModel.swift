//
//  LoginViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 13/04/26.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func didUpdateFormVaidity(isValid: Bool)
    func didValidateField(field: LoginViewModel.LoginFieldType, isValid: Bool)
    func didLoginSuccess()
}

final class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    private var email: String?
    private var password: String?
    
    enum LoginFieldType {
        case email
        case password
    }
    
    func updateField(field: LoginFieldType, value: String?) {
        switch field {
        case .email:
            email = value
            delegate?.didValidateField(field: .email, isValid: InputValidator.validateEmail(text: value))
        case .password:
            password = value
            delegate?.didValidateField(field: .password, isValid: InputValidator.validatePassword(text: value))
        }
        delegate?.didUpdateFormVaidity(isValid: isFormValid())
    }
    
    func login() {
        guard isFormValid() else { return }
        // Integração futura com camada de serviço (Firebase Auth)
        delegate?.didLoginSuccess()
    }
    
    func isFormValid() -> Bool {
        return InputValidator.validateEmail(text: email) &&
               InputValidator.validatePassword(text: password)
    }
}
