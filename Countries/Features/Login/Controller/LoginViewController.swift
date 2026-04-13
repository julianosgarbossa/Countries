//
//  LoginViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class LoginViewController: UIViewController {

    private var loginScreen: LoginScreen?
    private let loginViewModel = LoginViewModel()
    private let defaultBorderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
    
    override func loadView() {
        loginScreen = LoginScreen()
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationControler()
    }
    
    func configProtocols() {
        loginScreen?.delegate(delegate: self)
        loginScreen?.configTextField(delegate: self)
        loginViewModel.delegate = self
    }
    
    func configNavigationControler() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backButtonTitle = "Login"
    }
}

extension LoginViewController: LoginScreenDelegate {
    func didTapRecoverPasswordButton() {
        let passwordRecoveryViewController = PasswordRecoveryViewController()
        navigationController?.pushViewController(passwordRecoveryViewController, animated: true)
    }
    
    func didTapLoginButton() {
        print("Enviando Para API Firebase Auth -> Logando Usuario")
        loginViewModel.login()
    }
    
    func didTapRegisterButton() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let loginScreen else { return true }
        
        let textAfterChange = (textField.text ?? "").applyingReplacement(range: range, with: string)
        
        switch textField {
        case loginScreen.emailTextField:
            loginViewModel.updateField(field: .email, value: textAfterChange)
        case loginScreen.passwordTextField:
            loginViewModel.updateField(field: .password, value: textAfterChange)
        default:
            return true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let loginScreen else { return true }

        switch textField {
        case loginScreen.emailTextField:
            loginScreen.passwordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func didUpdateFormVaidity(isValid: Bool) {
        loginScreen?.setLoginButtonEnabled(isValid)
    }
    
    func didValidateField(field: LoginViewModel.LoginFieldType, isValid: Bool) {
        guard let loginScreen else { return }
        
        let textField: UITextField

        switch field {
        case .email:
            textField = loginScreen.emailTextField
        case .password:
            textField = loginScreen.passwordTextField
        }

        textField.layer.borderColor = isValid ? defaultBorderColor : UIColor.red.cgColor
    }
    
    func didLoginSuccess() {
        print("Resposta da API Firebase Auth -> Sucesso ou Falha")
        let tabBarController = TabBarController()
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
}
