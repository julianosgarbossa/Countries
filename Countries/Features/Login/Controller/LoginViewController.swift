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
        navigationController?.navigationBar.isHidden = true
    }
    
    func configProtocols() {
        loginScreen?.delegate(delegate: self)
    }
}

extension LoginViewController: LoginScreenDelegate {
    func didTapRecoverPasswordButton() {
        print("Recuperando Senha....")
    }
    
    func didTapLoginButton() {
        print("Logando...")
    }
    
    func didTapRegisterButton() {
        print("Navegando Tela Registro...")
    }
}
