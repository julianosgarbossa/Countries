//
//  EditProfileViewModel.swift
//  Countries
//
//  Created by Marcelo Araujo on 20/04/26.
//

import UIKit
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
    var newProfileImage: UIImage?
    private var hasPhotoChange = false

    let prefilledName: String

    var photoURL: URL? {
        AuthService.shared.currentUser?.photoURL
    }

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

    func setNewPhoto(_ image: UIImage) {
        newProfileImage = image
        hasPhotoChange = true
        delegate?.didUpdateFormValidity(isValid: isSaveEnabled())
    }

    func save() {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard isSaveEnabled() else { return }

        delegate?.didChangeLoadingState(isLoading: true)

        let nameChanged = trimmed != initialName && InputValidator.validateName(text: trimmed)

        let group = DispatchGroup()
        var errors: [String] = []

        if nameChanged {
            group.enter()
            AuthService.shared.updateDisplayName(trimmed) { result in
                if case .failure(let error) = result {
                    errors.append(FirebaseErrorMapper.message(for: error))
                }
                group.leave()
            }
        }

        if hasPhotoChange, let image = newProfileImage {
            group.enter()
            StorageService.shared.uploadProfilePhoto(image) { result in
                switch result {
                case .success(let url):
                    AuthService.shared.updatePhotoURL(url) { _ in
                        group.leave()
                    }
                case .failure(let error):
                    errors.append(error.localizedDescription)
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) { [weak self] in
            self?.delegate?.didChangeLoadingState(isLoading: false)
            if errors.isEmpty {
                self?.delegate?.didUpdateSuccess()
            } else {
                self?.delegate?.didUpdateFailure(message: errors.joined(separator: "\n"))
            }
        }
    }

    private func isSaveEnabled() -> Bool {
        let nameValid = InputValidator.validateName(text: name)
        let nameChanged = name.trimmingCharacters(in: .whitespacesAndNewlines) != initialName
        return (nameValid && nameChanged) || hasPhotoChange
    }
}
