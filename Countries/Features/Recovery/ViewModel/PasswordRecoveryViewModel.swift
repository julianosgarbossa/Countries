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
    func didRecoveryFailure(message: String)
    func didChangeLoadingState(isLoading: Bool)
}

final class PasswordRecoveryViewModel {

    weak var delegate: PasswordRecoveryViewModelDelegate?

    private var email: String?

    func updateFieldAndButton(value: String?) {
        email = value
        delegate?.didValidateFieldAndButton(isValid: InputValidator.validateEmail(text: email))
    }

    func passwordRecovery() {
        guard let email = email?.trimmingCharacters(in: .whitespacesAndNewlines),
              InputValidator.validateEmail(text: email) else { return }

        delegate?.didChangeLoadingState(isLoading: true)

        AuthService.shared.sendPasswordReset(email: email) { [weak self] result in
            DispatchQueue.main.async {
                self?.delegate?.didChangeLoadingState(isLoading: false)
                switch result {
                case .success:
                    self?.delegate?.didRecoverySuccess()
                case .failure(let error):
                    self?.delegate?.didRecoveryFailure(message: FirebaseErrorMapper.message(for: error))
                }
            }
        }
    }
}
