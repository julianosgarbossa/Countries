//
//  ProfileViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileScren: ProfileScreen?
    
    override func loadView() {
        profileScren = ProfileScreen()
        view = profileScren
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationControler()
        configProtocols()
    }
    
    private func configNavigationControler() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configProtocols() {
        profileScren?.delegate(delegate: self)
    }
}

extension ProfileViewController: ProfileScreenDelegate {
    func didTapLogoutButton() {
        let loginViewController = LoginViewController()
        let nav = UINavigationController(rootViewController: loginViewController)
        view.window?.rootViewController = nav
        view.window?.makeKeyAndVisible()
    }
}
