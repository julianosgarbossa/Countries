//
//  RegisterViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 13/04/26.
//

import Foundation

protocol RegisterViewModelDelegate: AnyObject {
    func didUpdateFormVaidity(isValid: Bool)
    func didValidateField(field: RegisterViewModel.RegisterFieldType, isValid: Bool)
    func didRegisterSuccess()
}

final class RegisterViewModel {
    
    weak var delegate: RegisterViewModelDelegate?
    
    enum RegisterFieldType {
        case name
        case email
        case password
        case confirmPassword
    }
    
    private var name: String?
    private var email: String?
    private var password: String?
    private var confirmPassword: String?
    
    func updateField(field: RegisterFieldType, value: String?) {
        switch field {
        case .name:
            name = value
            delegate?.didValidateField(field: .name, isValid: InputValidator.validateName(text: value))
        case .email:
            email = value
            delegate?.didValidateField(field: .email, isValid: InputValidator.validateEmail(text: value))
        case .password:
            password = value
            delegate?.didValidateField(field: .password, isValid: InputValidator.validatePassword(text: value))
        case .confirmPassword:
            confirmPassword = value
            delegate?.didValidateField(field: .confirmPassword, isValid: InputValidator.validateConfirmPassword(password: password,                                                                                                   confirmPassword: value))
        }
        delegate?.didUpdateFormVaidity(isValid: isFormValid())
    }
    
    func register() {
        guard isFormValid() else { return }
        // Integração futura com camada de serviço (Firebase Auth)
        delegate?.didRegisterSuccess()
    }
    
    func isFormValid() -> Bool {
        return InputValidator.validateName(text: name) &&
               InputValidator.validateEmail(text: email) &&
               InputValidator.validatePassword(text: password) &&
               InputValidator.validateConfirmPassword(password: password,
                                                      confirmPassword: confirmPassword)
    }
}
