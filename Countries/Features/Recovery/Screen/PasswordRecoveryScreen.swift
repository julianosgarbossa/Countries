//
//  PasswordRecoveryScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 13/04/26.
//

import UIKit

protocol PasswordRecoveryScreenDelegate: AnyObject {
    func didTapSendRecoveryLinkButton()
}

class PasswordRecoveryScreen: UIView {
    
    private weak var delegate: PasswordRecoveryScreenDelegate?
    
    func delegate(delegate: PasswordRecoveryScreenDelegate) {
        self.delegate = delegate
    }
    
    private lazy var cardPasswordRecoveryView: UIView = {
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
    
    private lazy var passwordRecoveryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recuperar Senha"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionPasswordRecoveryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Informe seu e-mail e enviaremos um link para redifinir sua senha."
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
    
    private lazy var sendRecoveryLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enviar Link de Recuperação", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1
        button.backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapSendRecoveryLinkButton), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    @objc
    private func didTapSendRecoveryLinkButton(_ sender: UIButton) {
        delegate?.didTapSendRecoveryLinkButton()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        
        addSubview(cardPasswordRecoveryView)
        addSubview(passwordRecoveryTitleLabel)
        addSubview(descriptionPasswordRecoveryLabel)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(sendRecoveryLinkButton)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            cardPasswordRecoveryView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cardPasswordRecoveryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardPasswordRecoveryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardPasswordRecoveryView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            passwordRecoveryTitleLabel.topAnchor.constraint(equalTo: cardPasswordRecoveryView.topAnchor, constant: 24),
            passwordRecoveryTitleLabel.centerXAnchor.constraint(equalTo: cardPasswordRecoveryView.centerXAnchor),
            
            descriptionPasswordRecoveryLabel.topAnchor.constraint(equalTo: passwordRecoveryTitleLabel.bottomAnchor, constant: 24),
            descriptionPasswordRecoveryLabel.leadingAnchor.constraint(equalTo: cardPasswordRecoveryView.leadingAnchor, constant: 16),
            descriptionPasswordRecoveryLabel.trailingAnchor.constraint(equalTo: cardPasswordRecoveryView.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: descriptionPasswordRecoveryLabel.bottomAnchor, constant: 24),
            emailLabel.leadingAnchor.constraint(equalTo: descriptionPasswordRecoveryLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: descriptionPasswordRecoveryLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
            emailTextField.leadingAnchor.constraint(equalTo: descriptionPasswordRecoveryLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: descriptionPasswordRecoveryLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            sendRecoveryLinkButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 34),
            sendRecoveryLinkButton.leadingAnchor.constraint(equalTo: descriptionPasswordRecoveryLabel.leadingAnchor),
            sendRecoveryLinkButton.trailingAnchor.constraint(equalTo: descriptionPasswordRecoveryLabel.trailingAnchor),
            sendRecoveryLinkButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
        ])
    }
    
    func configTextField(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
    }
    
    func setSendRecoveryLinkButtonEnabled(_ enabled: Bool) {
        sendRecoveryLinkButton.isEnabled = enabled
        sendRecoveryLinkButton.alpha = enabled ? 1.0 : 0.5
    }
}
