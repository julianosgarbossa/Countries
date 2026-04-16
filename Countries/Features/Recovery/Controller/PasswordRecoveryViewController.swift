//
//  PasswordRecoveryViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 13/04/26.
//

import UIKit

class PasswordRecoveryViewController: UIViewController {

    private var passwordRecoveryScreen: PasswordRecoveryScreen?
    private let passwordRecoveryViewModel = PasswordRecoveryViewModel()
    private let defaultBorderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor

    override func loadView() {
        passwordRecoveryScreen = PasswordRecoveryScreen()
        view = passwordRecoveryScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
        configNavigationControler()
    }

    func configProtocols() {
        passwordRecoveryScreen?.delegate(delegate: self)
        passwordRecoveryScreen?.configTextField(delegate: self)
        passwordRecoveryViewModel.delegate = self
    }

    func configNavigationControler() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Erro",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension PasswordRecoveryViewController: PasswordRecoveryScreenDelegate {
    func didTapSendRecoveryLinkButton() {
        view.endEditing(true)
        passwordRecoveryViewModel.passwordRecovery()
    }
}

extension PasswordRecoveryViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textAfterChange = (textField.text ?? "").applyingReplacement(range: range, with: string)
        passwordRecoveryViewModel.updateFieldAndButton(value: textAfterChange)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension PasswordRecoveryViewController: PasswordRecoveryViewModelDelegate {
    func didValidateFieldAndButton(isValid: Bool) {
        passwordRecoveryScreen?.setEmailFieldBorderColor(isValid ? defaultBorderColor : UIColor.red.cgColor)
        passwordRecoveryScreen?.setSendRecoveryLinkButtonEnabled(isValid)
    }

    func didRecoverySuccess() {
        let alert = UIAlertController(
            title: "Link Enviado",
            message: "Enviamos um link de recuperação para o e-mail informado. Verifique sua caixa de entrada.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }

    func didRecoveryFailure(message: String) {
        showErrorAlert(message: message)
    }

    func didChangeLoadingState(isLoading: Bool) {
        passwordRecoveryScreen?.setSendRecoveryLinkButtonLoading(isLoading)
        passwordRecoveryScreen?.setFieldsEnabled(!isLoading)
    }
}
