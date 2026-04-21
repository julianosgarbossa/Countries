//
//  ChangePasswordViewController.swift
//  Countries
//
//  Created by Marcelo Araujo on 20/04/26.
//

import UIKit

final class ChangePasswordViewController: UIViewController {

    private var changePasswordScreen: ChangePasswordScreen?
    private let changePasswordViewModel = ChangePasswordViewModel()
    private let defaultBorderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor

    override func loadView() {
        changePasswordScreen = ChangePasswordScreen()
        view = changePasswordScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        changePasswordViewModel.delegate = self
        changePasswordScreen?.delegate(delegate: self)
        changePasswordScreen?.configTextField(delegate: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Alterar Senha"
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ChangePasswordViewController: ChangePasswordScreenDelegate {
    func didTapSaveButton() {
        view.endEditing(true)
        changePasswordViewModel.save()
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let changePasswordScreen,
              let fieldTag = changePasswordScreen.fieldType(for: textField) else { return true }

        let textAfterChange = (textField.text ?? "").applyingReplacement(range: range, with: string)
        let field: ChangePasswordViewModel.Field
        switch fieldTag {
        case .current:
            field = .current
        case .new:
            field = .new
        case .confirm:
            field = .confirm
        }
        changePasswordViewModel.updateField(field: field, value: textAfterChange)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        changePasswordScreen?.focusNextField(after: textField)
        return true
    }
}

extension ChangePasswordViewController: ChangePasswordViewModelDelegate {
    func didUpdateFormValidity(isValid: Bool) {
        changePasswordScreen?.setSaveButtonEnabled(isValid)
    }

    func didValidateField(field: ChangePasswordViewModel.Field, isValid: Bool) {
        guard let changePasswordScreen else { return }
        let tag: ChangePasswordFieldTag
        switch field {
        case .current:
            tag = .current
        case .new:
            tag = .new
        case .confirm:
            tag = .confirm
        }
        changePasswordScreen.setFieldBorderColor(field: tag, color: isValid ? defaultBorderColor : UIColor.red.cgColor)
    }

    func didUpdateSuccess() {
        let alert = UIAlertController(
            title: "Senha atualizada",
            message: "Sua senha foi alterada com sucesso.",
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
        changePasswordScreen?.setSaveButtonLoading(isLoading)
        changePasswordScreen?.setFieldsEnabled(!isLoading)
    }
}
