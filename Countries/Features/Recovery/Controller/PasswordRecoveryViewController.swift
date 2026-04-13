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
    }
    
    func configNavigationControler() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
    }
}

extension PasswordRecoveryViewController: PasswordRecoveryScreenDelegate {
    func didTapSendRecoveryLinkButton() {
        print("Enviar link para o email informado para redefinição de senha -> FirebaseAuth")
    }
}
