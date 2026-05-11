//
//  EditProfileViewController.swift
//  Countries
//
//  Created by Marcelo Araujo on 20/04/26.
//

import UIKit

final class EditProfileViewController: UIViewController {

    private var editProfileScreen: EditProfileScreen?
    private let editProfileViewModel = EditProfileViewModel()
    private let defaultBorderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor

    override func loadView() {
        editProfileScreen = EditProfileScreen()
        view = editProfileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        editProfileViewModel.delegate = self
        editProfileScreen?.delegate(delegate: self)
        editProfileScreen?.configTextField(delegate: self)
        applyInitialContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Editar Perfil"
    }

    private func applyInitialContent() {
        let name = editProfileViewModel.prefilledName
        editProfileScreen?.configure(name: name, email: editProfileViewModel.email)
        editProfileViewModel.updateName(name)

        if let photoURL = editProfileViewModel.photoURL {
            editProfileScreen?.loadProfilePhoto(from: photoURL)
        }
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension EditProfileViewController: EditProfileScreenDelegate {
    func didTapSaveButton() {
        view.endEditing(true)
        editProfileViewModel.save()
    }

    func didTapChangePhotoButton() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        if let image {
            editProfileScreen?.setProfilePhoto(image)
            editProfileViewModel.setNewPhoto(image)
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textAfterChange = (textField.text ?? "").applyingReplacement(range: range, with: string)
        editProfileViewModel.updateName(textAfterChange)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EditProfileViewController: EditProfileViewModelDelegate {
    func didUpdateFormValidity(isValid: Bool) {
        editProfileScreen?.setSaveButtonEnabled(isValid)
    }

    func didValidateName(isValid: Bool) {
        editProfileScreen?.setNameFieldBorderColor(isValid ? defaultBorderColor : UIColor.red.cgColor)
    }

    func didUpdateSuccess() {
        let alert = UIAlertController(
            title: "Perfil atualizado",
            message: "Seu nome foi salvo com sucesso.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }

    func didUpdateFailure(message: String) {
        showErrorAlert(message: message)
    }

    func didChangeLoadingState(isLoading: Bool) {
        editProfileScreen?.setSaveButtonLoading(isLoading)
        editProfileScreen?.setFieldsEnabled(!isLoading)
    }
}
