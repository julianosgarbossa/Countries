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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        loadProfileData()
    }

    private func configNavigationControler() {
        navigationController?.navigationBar.isHidden = true
    }

    private func configProtocols() {
        profileScreen?.delegate(delegate: self)
        profileViewModel.delegate = self
    }

    private func loadProfileData() {
        profileScreen?.configureProfile(
            name: profileViewModel.userName,
            email: profileViewModel.userEmail,
            version: profileViewModel.appVersion
        )
    }

    private func navigateToLogin() {
        let loginViewController = LoginViewController()
        let nav = UINavigationController(rootViewController: loginViewController)
        view.window?.rootViewController = nav
        view.window?.makeKeyAndVisible()
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

// MARK: - ProfileScreenDelegate

extension ProfileViewController: ProfileScreenDelegate {
    func didTapEditProfileButton() {
        let editProfileViewController = EditProfileViewController()
        navigationController?.pushViewController(editProfileViewController, animated: true)
    }

    func didTapChangePasswordButton() {
        let changePasswordViewController = ChangePasswordViewController()
        navigationController?.pushViewController(changePasswordViewController, animated: true)
    }

    func didTapPrivacyPolicyButton() {
        guard let url = URL(string: "https://www.example.com/privacy") else { return }
        UIApplication.shared.open(url)
    }

    func didTapTermsOfUseButton() {
        guard let url = URL(string: "https://www.example.com/terms") else { return }
        UIApplication.shared.open(url)
    }

    func didTapLogoutButton() {
        let alert = UIAlertController(
            title: "Sair da Conta",
            message: "Tem certeza que deseja sair?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Sair", style: .destructive) { [weak self] _ in
            self?.profileViewModel.logout()
        })
        present(alert, animated: true)
    }

    func didTapDeleteAccountButton() {
        let alert = UIAlertController(
            title: "Excluir Conta",
            message: "Essa ação é irreversível. Todos os seus dados serão permanentemente removidos. Deseja continuar?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Excluir", style: .destructive) { [weak self] _ in
            self?.profileViewModel.deleteAccount()
        })
        present(alert, animated: true)
    }
}

// MARK: - ProfileViewModelDelegate

extension ProfileViewController: ProfileViewModelDelegate {
    func didLogoutSuccess() {
        navigateToLogin()
    }

    func didLogoutFailure(message: String) {
        showErrorAlert(message: message)
    }

    func didDeleteAccountSuccess() {
        let alert = UIAlertController(
            title: "Conta Excluída",
            message: "Sua conta foi excluída com sucesso.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigateToLogin()
        })
        present(alert, animated: true)
    }

    func didDeleteAccountFailure(message: String) {
        showErrorAlert(message: message)
    }

    func didChangeLoadingState(isLoading: Bool) {
        profileScreen?.setDeleteAccountButtonLoading(isLoading)
        profileScreen?.setButtonsEnabled(!isLoading)
    }
}
