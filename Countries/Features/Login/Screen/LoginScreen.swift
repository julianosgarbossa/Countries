//
//  LoginScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

protocol LoginScreenDelegate: AnyObject {
    func didTapRecoverPasswordButton()
    func didTapLoginButton()
    func didTapRegisterButton()
}

class LoginScreen: UIView {

    private weak var delegate: LoginScreenDelegate?
    
    func delegate(delegate: LoginScreenDelegate) {
        self.delegate = delegate
    }
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.contentInsetAdjustmentBehavior = .automatic
        scroll.isDirectionalLockEnabled = true
        scroll.backgroundColor = .clear
        return scroll
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var cardLogoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        return view
    }()
    
    private lazy var logoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }()
    
    private lazy var globeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "globe.americas.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Countries"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        return label
    }()
    
    private lazy var cardLoginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 48
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private lazy var loginTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Informe seu email"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .left
        textField.borderStyle = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 24
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.isSecureTextEntry = false
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Senha"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Informe sua senha"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .left
        textField.borderStyle = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 24
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var recoverPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Recuperar senha?", for: .normal)
        button.setTitleColor(UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.numberOfLines = 1
        button.addTarget(self, action: #selector(didTapRecoverPasswordButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1
        button.backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Não tem uma conta?"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastre-se", for: .normal)
        button.setTitleColor(UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.numberOfLines = 1
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomSpacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    @objc
    private func didTapLoginButton(_ sender: UIButton) {
        delegate?.didTapLoginButton()
    }
    
    @objc
    private func didTapRecoverPasswordButton(_ sender: UIButton) {
        delegate?.didTapRecoverPasswordButton()
    }
    
    @objc
    private func didTapRegisterButton(_ sender: UIButton) {
        delegate?.didTapRegisterButton()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        backgroundColor = .white
        
        addSubview(headerView)
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(cardLogoView)
        cardLogoView.addSubview(logoStackView)
        logoStackView.addArrangedSubview(globeImageView)
        logoStackView.addArrangedSubview(logoLabel)
        containerView.addSubview(cardLoginView)
        cardLoginView.addSubview(loginTitleLabel)
        cardLoginView.addSubview(emailLabel)
        cardLoginView.addSubview(emailTextField)
        cardLoginView.addSubview(passwordLabel)
        cardLoginView.addSubview(passwordTextField)
        cardLoginView.addSubview(recoverPasswordButton)
        cardLoginView.addSubview(loginButton)
        cardLoginView.addSubview(registerLabel)
        cardLoginView.addSubview(registerButton)
        cardLoginView.addSubview(bottomSpacerView)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            containerView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor),
            
            cardLogoView.topAnchor.constraint(equalTo: containerView.topAnchor),
            cardLogoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cardLogoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cardLogoView.heightAnchor.constraint(equalToConstant: 350),
            
            logoStackView.centerXAnchor.constraint(equalTo: cardLogoView.centerXAnchor),
            logoStackView.centerYAnchor.constraint(equalTo: cardLogoView.centerYAnchor, constant: -50),
            
            globeImageView.heightAnchor.constraint(equalToConstant: 90),
            globeImageView.widthAnchor.constraint(equalToConstant: 90),
            
            cardLoginView.topAnchor.constraint(equalTo: cardLogoView.bottomAnchor, constant: -50),
            cardLoginView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cardLoginView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cardLoginView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            loginTitleLabel.topAnchor.constraint(equalTo: cardLoginView.topAnchor, constant: 24),
            loginTitleLabel.centerXAnchor.constraint(equalTo: cardLoginView.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor, constant: 24),
            emailLabel.leadingAnchor.constraint(equalTo: cardLoginView.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: cardLoginView.trailingAnchor, constant: -16),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            recoverPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 4),
            recoverPasswordButton.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            recoverPasswordButton.heightAnchor.constraint(equalToConstant: 24),
            
            loginButton.topAnchor.constraint(equalTo: recoverPasswordButton.bottomAnchor, constant: 34),
            loginButton.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            loginButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            registerLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 44),
            registerLabel.centerXAnchor.constraint(equalTo: cardLoginView.centerXAnchor, constant: -44),
            
            registerButton.centerYAnchor.constraint(equalTo: registerLabel.centerYAnchor),
            registerButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor, constant: 4),
            registerButton.heightAnchor.constraint(equalTo: recoverPasswordButton.heightAnchor),
            
            bottomSpacerView.topAnchor.constraint(equalTo: registerButton.bottomAnchor),
            bottomSpacerView.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            bottomSpacerView.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            bottomSpacerView.bottomAnchor.constraint(equalTo: cardLoginView.bottomAnchor),
        ])
        
        let spacerMinHeight = bottomSpacerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        spacerMinHeight.priority = .defaultLow
        spacerMinHeight.isActive = true
    }
    
    func configTextField(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    func setLoginButtonEnabled(_ enabled: Bool) {
        loginButton.isEnabled = enabled
        loginButton.alpha = enabled ? 1.0 : 0.5
    }
}
