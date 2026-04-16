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
    
    private func configProtocols() {
        loginScreen?.delegate(delegate: self)
        loginScreen?.configTextField(delegate: self)
        loginViewModel.delegate = self
    }
    
    private func configNavigationControler() {
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
        loginViewModel.login()
    }
    
    func didTapRegisterButton() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let loginScreen,
              let fieldTag = loginScreen.loginFieldType(for: textField) else { return true }
        
        let textAfterChange = (textField.text ?? "").applyingReplacement(range: range, with: string)
        
        switch fieldTag {
        case .email:
            loginViewModel.updateField(field: .email, value: textAfterChange)
        case .password:
            loginViewModel.updateField(field: .password, value: textAfterChange)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginScreen?.focusNextField(after: textField)
        return true
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func didUpdateFormVaidity(isValid: Bool) {
        loginScreen?.setLoginButtonEnabled(isValid)
    }
    
    func didValidateField(field: LoginViewModel.LoginFieldType, isValid: Bool) {
        guard let loginScreen else { return }
        
        let fieldTag: LoginFieldTag
        switch field {
        case .email:
            fieldTag = .email
        case .password:
            fieldTag = .password
        }
        
        loginScreen.setFieldBorderColor(field: fieldTag, color: isValid ? defaultBorderColor : UIColor.red.cgColor)
    }
    
    func didLoginSuccess() {
        let tabBarController = TabBarController()
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
}
