//
//  RegisterScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

protocol RegisterScreenDelegate: AnyObject {
    func didTapRegisterButton()
}

enum RegisterFieldTag: Int {
    case name = 200
    case email = 201
    case password = 202
    case confirmPassword = 203
}

class RegisterScreen: UIView {

    private weak var delegate: RegisterScreenDelegate?
    
    func delegate(delegate: RegisterScreenDelegate) {
        self.delegate = delegate
    }
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentInsetAdjustmentBehavior = .automatic
        scroll.backgroundColor = .clear
        return scroll
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var cardView: UIView = {
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
    
    private lazy var registerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cadastro"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var photoContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 51
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person")
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 60, weight: .ultraLight, scale: .default)
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        imageView.layer.cornerRadius = 50
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var photoEditButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Editar", for: .normal)
        button.setTitleColor(UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1
        button.addTarget(self, action: #selector(didTapEditPhotoButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Informe o nome completo"
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
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.isSecureTextEntry = false
        textField.tag = RegisterFieldTag.name.rawValue
        return textField
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
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Informe o email"
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
        textField.tag = RegisterFieldTag.email.rawValue
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
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Informe uma senha"
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
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.isSecureTextEntry = true
        textField.tag = RegisterFieldTag.password.rawValue
        return textField
    }()
    
    private lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Confirmar Senha"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Informe a senha novamente"
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
        textField.tag = RegisterFieldTag.confirmPassword.rawValue
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1
        button.backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private lazy var bottomSpacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    @objc
    func didTapEditPhotoButton(_ sender: UIButton) {
        print("Editando foto...")
        setPhotoImageView()
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
        containerView.addSubview(cardView)
        cardView.addSubview(registerTitleLabel)
        cardView.addSubview(photoContentView)
        cardView.addSubview(photoImageView)
        cardView.addSubview(photoEditButton)
        cardView.addSubview(nameLabel)
        cardView.addSubview(nameTextField)
        cardView.addSubview(emailLabel)
        cardView.addSubview(emailTextField)
        cardView.addSubview(passwordLabel)
        cardView.addSubview(passwordTextField)
        cardView.addSubview(confirmPasswordLabel)
        cardView.addSubview(confirmPasswordTextField)
        cardView.addSubview(registerButton)
        cardView.addSubview(bottomSpacerView)
        
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
   
            cardView.topAnchor.constraint(equalTo: containerView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            registerTitleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 24),
            registerTitleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            
            photoContentView.topAnchor.constraint(equalTo: registerTitleLabel.bottomAnchor, constant: 24),
            photoContentView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            photoContentView.heightAnchor.constraint(equalToConstant: 101),
            photoContentView.widthAnchor.constraint(equalToConstant: 101),
            
            photoImageView.centerXAnchor.constraint(equalTo: photoContentView.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: photoContentView.centerYAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            photoEditButton.topAnchor.constraint(equalTo: photoContentView.bottomAnchor, constant: 12),
            photoEditButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: photoEditButton.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
            emailTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            confirmPasswordLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 12),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 44),
            registerButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            registerButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            bottomSpacerView.topAnchor.constraint(equalTo: registerButton.bottomAnchor),
            bottomSpacerView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            bottomSpacerView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            bottomSpacerView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
        ])
        
        let spacerMinHeight = bottomSpacerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        spacerMinHeight.priority = .defaultLow
        spacerMinHeight.isActive = true
    }
    
    func configTextField(delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
        confirmPasswordTextField.delegate = delegate
    }
    
    func registerFieldType(for textField: UITextField) -> RegisterFieldTag? {
        RegisterFieldTag(rawValue: textField.tag)
    }
    
    func setFieldBorderColor(field: RegisterFieldTag, color: CGColor) {
        switch field {
        case .name:
            nameTextField.layer.borderColor = color
        case .email:
            emailTextField.layer.borderColor = color
        case .password:
            passwordTextField.layer.borderColor = color
        case .confirmPassword:
            confirmPasswordTextField.layer.borderColor = color
        }
    }
    
    func focusNextField(after textField: UITextField) {
        switch RegisterFieldTag(rawValue: textField.tag) {
        case .name:
            emailTextField.becomeFirstResponder()
        case .email:
            passwordTextField.becomeFirstResponder()
        case .password:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
    }
    
    func setRegisterButtonEnabled(_ enabled: Bool) {
        registerButton.isEnabled = enabled
        registerButton.alpha = enabled ? 1.0 : 0.5
    }
    
    private func setPhotoImageView() {
        photoImageView.image = UIImage(named: "photo")
        photoImageView.contentMode = .scaleAspectFill
    }

    func setRegisterButtonLoading(_ isLoading: Bool) {
        if isLoading {
            registerButton.setTitle("", for: .normal)
            registerButton.isEnabled = false
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.color = .white
            spinner.tag = 9999
            spinner.translatesAutoresizingMaskIntoConstraints = false
            registerButton.addSubview(spinner)
            NSLayoutConstraint.activate([
                spinner.centerXAnchor.constraint(equalTo: registerButton.centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: registerButton.centerYAnchor),
            ])
            spinner.startAnimating()
        } else {
            registerButton.setTitle("Cadastrar", for: .normal)
            if let spinner = registerButton.viewWithTag(9999) as? UIActivityIndicatorView {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
        }
    }

    func setFieldsEnabled(_ enabled: Bool) {
        nameTextField.isEnabled = enabled
        emailTextField.isEnabled = enabled
        passwordTextField.isEnabled = enabled
        confirmPasswordTextField.isEnabled = enabled
    }
}
