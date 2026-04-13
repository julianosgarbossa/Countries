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
}

extension PasswordRecoveryViewController: PasswordRecoveryScreenDelegate {
    func didTapSendRecoveryLinkButton() {
        print("Enviando link para o email informado para redefinição de senha -> FirebaseAuth")
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
        passwordRecoveryScreen?.emailTextField.layer.borderColor = isValid ? defaultBorderColor : UIColor.red.cgColor
        passwordRecoveryScreen?.setSendRecoveryLinkButtonEnabled(isValid)
    }
    
    func didRecoverySuccess() {
        print("Resposta do Link de Recuperação Enviado -> Sucesso ou Error")
    }
}
