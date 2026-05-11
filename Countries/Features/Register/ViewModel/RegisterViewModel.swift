//
//  RegisterViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 13/04/26.
//

import UIKit

protocol RegisterViewModelDelegate: AnyObject {
    func didUpdateFormVaidity(isValid: Bool)
    func didValidateField(field: RegisterViewModel.RegisterFieldType, isValid: Bool)
    func didRegisterSuccess()
    func didRegisterFailure(message: String)
    func didChangeLoadingState(isLoading: Bool)
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
    var profileImage: UIImage?

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
            delegate?.didValidateField(field: .confirmPassword, isValid: InputValidator.validateConfirmPassword(password: password,
                                                                                                                confirmPassword: value))
        }
        delegate?.didUpdateFormVaidity(isValid: isFormValid())
    }

    func register() {
        guard isFormValid(),
              let email = email?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password,
              let name = name?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

        delegate?.didChangeLoadingState(isLoading: true)

        AuthService.shared.register(email: email, password: password) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success:
                AuthService.shared.updateDisplayName(name) { [weak self] _ in
                    guard let self else { return }

                    FavoritesRepository.shared.syncAfterLogin { [weak self] in
                        guard let self else { return }
                        if let image = self.profileImage {
                            self.uploadProfilePhoto(image)
                        } else {
                            DispatchQueue.main.async {
                                self.delegate?.didChangeLoadingState(isLoading: false)
                                self.delegate?.didRegisterSuccess()
                            }
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.didChangeLoadingState(isLoading: false)
                    self.delegate?.didRegisterFailure(message: FirebaseErrorMapper.message(for: error))
                }
            }
        }
    }

    private func uploadProfilePhoto(_ image: UIImage) {
        StorageService.shared.uploadProfilePhoto(image) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let url):
                AuthService.shared.updatePhotoURL(url) { _ in
                    DispatchQueue.main.async {
                        self.delegate?.didChangeLoadingState(isLoading: false)
                        self.delegate?.didRegisterSuccess()
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self.delegate?.didChangeLoadingState(isLoading: false)
                    self.delegate?.didRegisterSuccess()
                }
            }
        }
    }

    func isFormValid() -> Bool {
        return InputValidator.validateName(text: name) &&
               InputValidator.validateEmail(text: email) &&
               InputValidator.validatePassword(text: password) &&
               InputValidator.validateConfirmPassword(password: password,
                                                      confirmPassword: confirmPassword)
    }
}
