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
    func didLoginFailure(message: String)
    func didChangeLoadingState(isLoading: Bool)
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
        guard isFormValid(),
              let email = email?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password else { return }

        delegate?.didChangeLoadingState(isLoading: true)

        AuthService.shared.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.didChangeLoadingState(isLoading: false)
                switch result {
                case .success:
                    self?.delegate?.didLoginSuccess()
                case .failure(let error):
                    self?.delegate?.didLoginFailure(message: FirebaseErrorMapper.message(for: error))
                }
            }
        }
    }

    func isFormValid() -> Bool {
        return InputValidator.validateEmail(text: email) &&
               InputValidator.validatePassword(text: password)
    }
}
