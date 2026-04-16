//
//  ProfileViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileScreen: ProfileScreen?
    private let profileViewModel = ProfileViewModel()
    
    override func loadView() {
        profileScreen = ProfileScreen()
        view = profileScreen
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
        profileScreen?.delegate(delegate: self)
        profileViewModel.delegate = self
    }
}

extension ProfileViewController: ProfileScreenDelegate {
    func didTapLogoutButton() {
        profileViewModel.logout()
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func didLogoutSuccess() {
        let loginViewController = LoginViewController()
        let nav = UINavigationController(rootViewController: loginViewController)
        view.window?.rootViewController = nav
        view.window?.makeKeyAndVisible()
    }
}
