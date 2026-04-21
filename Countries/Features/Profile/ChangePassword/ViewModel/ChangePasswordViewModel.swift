//
//  ChangePasswordViewModel.swift
//  Countries
//
//  Created by Marcelo Araujo on 20/04/26.
//

import Foundation

protocol ChangePasswordViewModelDelegate: AnyObject {
    func didUpdateFormValidity(isValid: Bool)
    func didValidateField(field: ChangePasswordViewModel.Field, isValid: Bool)
    func didUpdateSuccess()
    func didUpdateFailure(message: String)
    func didChangeLoadingState(isLoading: Bool)
}

final class ChangePasswordViewModel {

    enum Field {
        case current
        case new
        case confirm
    }

    weak var delegate: ChangePasswordViewModelDelegate?

    private var currentPassword: String?
    private var newPassword: String?
    private var confirmPassword: String?

    func updateField(field: Field, value: String?) {
        switch field {
        case .current:
            currentPassword = value
            delegate?.didValidateField(field: .current, isValid: validateCurrentPassword(text: value))
        case .new:
            newPassword = value
            delegate?.didValidateField(field: .new, isValid: InputValidator.validatePassword(text: value))
            delegate?.didValidateField(
                field: .confirm,
                isValid: InputValidator.validateConfirmPassword(password: value, confirmPassword: confirmPassword)
            )
        case .confirm:
            confirmPassword = value
            delegate?.didValidateField(
                field: .confirm,
                isValid: InputValidator.validateConfirmPassword(password: newPassword, confirmPassword: value)
            )
        }
        delegate?.didUpdateFormValidity(isValid: isFormValid())
    }

    func save() {
        guard isFormValid(),
              let current = currentPassword,
              let newPass = newPassword else { return }

        delegate?.didChangeLoadingState(isLoading: true)

        AuthService.shared.updatePassword(currentPassword: current, newPassword: newPass) { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.didChangeLoadingState(isLoading: false)
                switch result {
                case .success:
                    self?.delegate?.didUpdateSuccess()
                case .failure(let error):
                    self?.delegate?.didUpdateFailure(message: FirebaseErrorMapper.message(for: error))
                }
            }
        }
    }

    private func validateCurrentPassword(text: String?) -> Bool {
        guard let text, !text.isEmpty else { return false }
        return InputValidator.validatePassword(text: text)
    }

    private func isFormValid() -> Bool {
        validateCurrentPassword(text: currentPassword) &&
            InputValidator.validatePassword(text: newPassword) &&
            InputValidator.validateConfirmPassword(password: newPassword, confirmPassword: confirmPassword)
    }
}
