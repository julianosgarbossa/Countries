//
//  EditProfileViewModel.swift
//  Countries
//
//  Created by Marcelo Araujo on 20/04/26.
//

import Foundation
import FirebaseAuth

protocol EditProfileViewModelDelegate: AnyObject {
    func didUpdateFormValidity(isValid: Bool)
    func didValidateName(isValid: Bool)
    func didUpdateSuccess()
    func didUpdateFailure(message: String)
    func didChangeLoadingState(isLoading: Bool)
}

final class EditProfileViewModel {

    weak var delegate: EditProfileViewModelDelegate?

    private var name: String
    private let initialName: String

    let prefilledName: String

    init() {
        let current = AuthService.shared.currentUser?.displayName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        self.prefilledName = current
        self.name = current
        self.initialName = current
    }

    var email: String {
        AuthService.shared.currentUser?.email ?? ""
    }

    func updateName(_ value: String?) {
        name = value ?? ""
        delegate?.didValidateName(isValid: InputValidator.validateName(text: name))
        delegate?.didUpdateFormValidity(isValid: isSaveEnabled())
    }

    func save() {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard isSaveEnabled(), InputValidator.validateName(text: trimmed) else { return }

        delegate?.didChangeLoadingState(isLoading: true)

        AuthService.shared.updateDisplayName(trimmed) { [weak self] result in
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

    private func isSaveEnabled() -> Bool {
        guard InputValidator.validateName(text: name) else { return false }
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed != initialName
    }
}
