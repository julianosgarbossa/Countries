//
//  ProfileScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

protocol ProfileScreenDelegate: AnyObject {
    func didTapEditProfileButton()
    func didTapChangePasswordButton()
    func didTapPrivacyPolicyButton()
    func didTapTermsOfUseButton()
    func didTapLogoutButton()
    func didTapDeleteAccountButton()
}

class ProfileScreen: UIView {

    private weak var delegate: ProfileScreenDelegate?

    func delegate(delegate: ProfileScreenDelegate) {
        self.delegate = delegate
    }

    // MARK: - Accent Color

    private let accentColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
    private let grayText = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
    /// Texto secundário sobre fundo claro (contraste WCAG em ~#F5F5F5)
    private let secondaryOnLightBackground = UIColor(red: 70/255, green: 70/255, blue: 74/255, alpha: 1)

    // MARK: - ScrollView

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.alwaysBounceVertical = true
        scroll.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return scroll
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - Header (dentro do scroll: texto branco fica sobre laranja — evita contraste ruim com o fundo cinza)

    private lazy var profileHeaderContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = accentColor
        view.layer.cornerRadius = 28
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var photoContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 80, weight: .ultraLight)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        imageView.layer.cornerRadius = 48
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Usuário"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "email@exemplo.com"
        label.textColor = UIColor(white: 1.0, alpha: 0.92)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    // MARK: - Conta Section

    private lazy var accountSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CONTA"
        label.textColor = grayText
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()

    private lazy var accountCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private lazy var editProfileRow: UIView = {
        return createMenuRow(
            icon: "person.fill",
            title: "Editar Perfil",
            action: #selector(didTapEditProfile)
        )
    }()

    private lazy var changePasswordRow: UIView = {
        return createMenuRow(
            icon: "lock.fill",
            title: "Alterar Senha",
            action: #selector(didTapChangePassword)
        )
    }()

    private lazy var accountSeparator: UIView = {
        return createSeparator()
    }()

    // MARK: - Legal Section

    private lazy var legalSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "LEGAL"
        label.textColor = grayText
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()

    private lazy var legalCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private lazy var privacyPolicyRow: UIView = {
        return createMenuRow(
            icon: "hand.raised.fill",
            title: "Política de Privacidade",
            action: #selector(didTapPrivacyPolicy)
        )
    }()

    private lazy var termsOfUseRow: UIView = {
        return createMenuRow(
            icon: "doc.text.fill",
            title: "Termos de Uso",
            action: #selector(didTapTermsOfUse)
        )
    }()

    private lazy var legalSeparator: UIView = {
        return createSeparator()
    }()

    // MARK: - Logout Button

    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sair da Conta", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1
        button.backgroundColor = accentColor
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        return button
    }()

    // MARK: - Delete Account Button

    private lazy var deleteAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Excluir Conta", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapDeleteAccount), for: .touchUpInside)
        return button
    }()

    // MARK: - Version Label

    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Versão 1.0 (1)"
        label.textColor = secondaryOnLightBackground
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc private func didTapEditProfile() {
        delegate?.didTapEditProfileButton()
    }

    @objc private func didTapChangePassword() {
        delegate?.didTapChangePasswordButton()
    }

    @objc private func didTapPrivacyPolicy() {
        delegate?.didTapPrivacyPolicyButton()
    }

    @objc private func didTapTermsOfUse() {
        delegate?.didTapTermsOfUseButton()
    }

    @objc private func didTapLogout() {
        delegate?.didTapLogoutButton()
    }

    @objc private func didTapDeleteAccount() {
        delegate?.didTapDeleteAccountButton()
    }

    // MARK: - Public API

    func configureProfile(name: String, email: String, version: String) {
        nameLabel.text = name
        emailLabel.text = email
        versionLabel.text = version
    }

    func setProfilePhoto(_ image: UIImage?) {
        guard let image else { return }
        photoImageView.image = image
        photoImageView.contentMode = .scaleAspectFill
    }

    // MARK: - Layout

    private func addVisualElements() {
        backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)

        addSubview(scrollView)
        scrollView.addSubview(containerView)

        containerView.addSubview(profileHeaderContainer)
        profileHeaderContainer.addSubview(photoContentView)
        photoContentView.addSubview(photoImageView)
        profileHeaderContainer.addSubview(nameLabel)
        profileHeaderContainer.addSubview(emailLabel)

        containerView.addSubview(accountSectionLabel)
        containerView.addSubview(accountCardView)
        accountCardView.addSubview(editProfileRow)
        accountCardView.addSubview(accountSeparator)
        accountCardView.addSubview(changePasswordRow)

        containerView.addSubview(legalSectionLabel)
        containerView.addSubview(legalCardView)
        legalCardView.addSubview(privacyPolicyRow)
        legalCardView.addSubview(legalSeparator)
        legalCardView.addSubview(termsOfUseRow)

        containerView.addSubview(logoutButton)
        containerView.addSubview(deleteAccountButton)
        containerView.addSubview(versionLabel)

        configConstraints()
    }

    private func configConstraints() {
        let horizontalPadding: CGFloat = 20

        NSLayoutConstraint.activate([
            // ScrollView (conteúdo do topo = bloco laranja com nome/email legíveis)
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Container
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            // Bloco laranja (foto + nome + email)
            profileHeaderContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            profileHeaderContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            profileHeaderContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            // Photo
            photoContentView.topAnchor.constraint(equalTo: profileHeaderContainer.topAnchor, constant: 24),
            photoContentView.centerXAnchor.constraint(equalTo: profileHeaderContainer.centerXAnchor),
            photoContentView.widthAnchor.constraint(equalToConstant: 100),
            photoContentView.heightAnchor.constraint(equalToConstant: 100),

            photoImageView.centerXAnchor.constraint(equalTo: photoContentView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: photoContentView.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 96),
            photoImageView.heightAnchor.constraint(equalToConstant: 96),

            // Name
            nameLabel.topAnchor.constraint(equalTo: photoContentView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: profileHeaderContainer.leadingAnchor, constant: horizontalPadding),
            nameLabel.trailingAnchor.constraint(equalTo: profileHeaderContainer.trailingAnchor, constant: -horizontalPadding),

            // Email
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: profileHeaderContainer.bottomAnchor, constant: -24),

            // Account Section
            accountSectionLabel.topAnchor.constraint(equalTo: profileHeaderContainer.bottomAnchor, constant: 24),
            accountSectionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalPadding + 4),
            accountSectionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -horizontalPadding),

            accountCardView.topAnchor.constraint(equalTo: accountSectionLabel.bottomAnchor, constant: 8),
            accountCardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: horizontalPadding),
            accountCardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -horizontalPadding),

            editProfileRow.topAnchor.constraint(equalTo: accountCardView.topAnchor),
            editProfileRow.leadingAnchor.constraint(equalTo: accountCardView.leadingAnchor),
            editProfileRow.trailingAnchor.constraint(equalTo: accountCardView.trailingAnchor),
            editProfileRow.heightAnchor.constraint(equalToConstant: 52),

            accountSeparator.topAnchor.constraint(equalTo: editProfileRow.bottomAnchor),
            accountSeparator.leadingAnchor.constraint(equalTo: accountCardView.leadingAnchor, constant: 52),
            accountSeparator.trailingAnchor.constraint(equalTo: accountCardView.trailingAnchor),
            accountSeparator.heightAnchor.constraint(equalToConstant: 0.5),

            changePasswordRow.topAnchor.constraint(equalTo: accountSeparator.bottomAnchor),
            changePasswordRow.leadingAnchor.constraint(equalTo: accountCardView.leadingAnchor),
            changePasswordRow.trailingAnchor.constraint(equalTo: accountCardView.trailingAnchor),
            changePasswordRow.heightAnchor.constraint(equalToConstant: 52),
            changePasswordRow.bottomAnchor.constraint(equalTo: accountCardView.bottomAnchor),

            // Legal Section
            legalSectionLabel.topAnchor.constraint(equalTo: accountCardView.bottomAnchor, constant: 24),
            legalSectionLabel.leadingAnchor.constraint(equalTo: accountSectionLabel.leadingAnchor),
            legalSectionLabel.trailingAnchor.constraint(equalTo: accountSectionLabel.trailingAnchor),

            legalCardView.topAnchor.constraint(equalTo: legalSectionLabel.bottomAnchor, constant: 8),
            legalCardView.leadingAnchor.constraint(equalTo: accountCardView.leadingAnchor),
            legalCardView.trailingAnchor.constraint(equalTo: accountCardView.trailingAnchor),

            privacyPolicyRow.topAnchor.constraint(equalTo: legalCardView.topAnchor),
            privacyPolicyRow.leadingAnchor.constraint(equalTo: legalCardView.leadingAnchor),
            privacyPolicyRow.trailingAnchor.constraint(equalTo: legalCardView.trailingAnchor),
            privacyPolicyRow.heightAnchor.constraint(equalToConstant: 52),

            legalSeparator.topAnchor.constraint(equalTo: privacyPolicyRow.bottomAnchor),
            legalSeparator.leadingAnchor.constraint(equalTo: legalCardView.leadingAnchor, constant: 52),
            legalSeparator.trailingAnchor.constraint(equalTo: legalCardView.trailingAnchor),
            legalSeparator.heightAnchor.constraint(equalToConstant: 0.5),

            termsOfUseRow.topAnchor.constraint(equalTo: legalSeparator.bottomAnchor),
            termsOfUseRow.leadingAnchor.constraint(equalTo: legalCardView.leadingAnchor),
            termsOfUseRow.trailingAnchor.constraint(equalTo: legalCardView.trailingAnchor),
            termsOfUseRow.heightAnchor.constraint(equalToConstant: 52),
            termsOfUseRow.bottomAnchor.constraint(equalTo: legalCardView.bottomAnchor),

            // Logout
            logoutButton.topAnchor.constraint(equalTo: legalCardView.bottomAnchor, constant: 32),
            logoutButton.leadingAnchor.constraint(equalTo: accountCardView.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: accountCardView.trailingAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 48),

            // Delete Account
            deleteAccountButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 12),
            deleteAccountButton.leadingAnchor.constraint(equalTo: accountCardView.leadingAnchor),
            deleteAccountButton.trailingAnchor.constraint(equalTo: accountCardView.trailingAnchor),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 48),

            // Version
            versionLabel.topAnchor.constraint(equalTo: deleteAccountButton.bottomAnchor, constant: 24),
            versionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
        ])
    }

    // MARK: - Row Factory

    private func createMenuRow(icon: String, title: String, action: Selector) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .clear

        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = accentColor
        iconView.contentMode = .scaleAspectFit

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)

        let chevron = UIImageView()
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.image = UIImage(systemName: "chevron.right")
        chevron.tintColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        chevron.contentMode = .scaleAspectFit

        let tap = UITapGestureRecognizer(target: self, action: action)
        container.addGestureRecognizer(tap)
        container.isUserInteractionEnabled = true

        container.addSubview(iconView)
        container.addSubview(titleLabel)
        container.addSubview(chevron)

        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 22),
            iconView.heightAnchor.constraint(equalToConstant: 22),

            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 14),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: chevron.leadingAnchor, constant: -8),

            chevron.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            chevron.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            chevron.widthAnchor.constraint(equalToConstant: 14),
            chevron.heightAnchor.constraint(equalToConstant: 14),
        ])

        return container
    }

    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return separator
    }
}
