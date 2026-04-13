//
//  RegisterViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class RegisterViewController: UIViewController {

    private var registerScreen: RegisterScreen?
    private let registerViewModel = RegisterViewModel()
    private let defaultBorderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationControler()
    }
    
    private func configProtocols() {
        registerScreen?.delegate(delegate: self)
        registerScreen?.configTextField(delegate: self)
        registerViewModel.delegate = self
    }
    
    private func configNavigationControler() {
        navigationController?.navigationBar.isHidden = false
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let registerScreen else { return true }

        let textAfterChange = (textField.text ?? "").applyingReplacement(range: range, with: string)

        switch textField {
        case registerScreen.nameTextField:
            registerViewModel.updateField(field: .name, value: textAfterChange)
        case registerScreen.emailTextField:
            registerViewModel.updateField(field: .email, value: textAfterChange)
        case registerScreen.passwordTextField:
            registerViewModel.updateField(field: .password, value: textAfterChange)
        case registerScreen.confirmPasswordTextField:
            registerViewModel.updateField(field: .confirmPassword, value: textAfterChange)
        default:
            return true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let registerScreen else { return true }

        switch textField {
        case registerScreen.nameTextField:
            registerScreen.emailTextField.becomeFirstResponder()
        case registerScreen.emailTextField:
            registerScreen.passwordTextField.becomeFirstResponder()
        case registerScreen.passwordTextField:
            registerScreen.confirmPasswordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

extension RegisterViewController: RegisterScreenDelegate {
    func didTapRegisterButton() {
        print("Enviando Para API Firebase Auth -> Registrando Usuario")
        registerViewModel.register()
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func didUpdateFormVaidity(isValid: Bool) {
        registerScreen?.setRegisterButtonEnabled(isValid)
    }
    
    func didValidateField(field: RegisterViewModel.RegisterFieldType, isValid: Bool) {
        guard let registerScreen = registerScreen else { return }
                let textField: UITextField
        
                switch field {
                case .name:
                    textField = registerScreen.nameTextField
                case .email:
                    textField = registerScreen.emailTextField
                case .password:
                    textField = registerScreen.passwordTextField
                case .confirmPassword:
                    textField = registerScreen.confirmPasswordTextField
                }

                textField.layer.borderColor = isValid ? defaultBorderColor : UIColor.red.cgColor
    }
    
    func didRegisterSuccess() {
        print("Resposta da API Firebase Auth -> Sucesso ou Falha")
    }
}
