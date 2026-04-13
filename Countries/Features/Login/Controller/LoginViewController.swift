//
//  LoginViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class LoginViewController: UIViewController {

    private var loginScreen: LoginScreen?
    
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
        let tabBarController = TabBarController()
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
    
    func didTapRegisterButton() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}
