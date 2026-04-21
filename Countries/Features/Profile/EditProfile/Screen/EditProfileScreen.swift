//
//  EditProfileScreen.swift
//  Countries
//
//  Created by Marcelo Araujo on 20/04/26.
//

import UIKit

protocol EditProfileScreenDelegate: AnyObject {
    func didTapSaveButton()
}

final class EditProfileScreen: UIView {

    private weak var delegate: EditProfileScreenDelegate?

    func delegate(delegate: EditProfileScreenDelegate) {
        self.delegate = delegate
    }

    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 48
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Editar Perfil"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Atualize como quer ser chamado no app. O e-mail não pode ser alterado aqui."
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var emailCaptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-mail"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var emailValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 2
        return label
    }()

    private lazy var nameCaptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Seu nome"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 24
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        return textField
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addVisualElements() {
        backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)

        addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(emailCaptionLabel)
        cardView.addSubview(emailValueLabel)
        cardView.addSubview(nameCaptionLabel)
        cardView.addSubview(nameTextField)
        cardView.addSubview(saveButton)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

            emailCaptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            emailCaptionLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            emailCaptionLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),

            emailValueLabel.topAnchor.constraint(equalTo: emailCaptionLabel.bottomAnchor, constant: 8),
            emailValueLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            emailValueLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),

            nameCaptionLabel.topAnchor.constraint(equalTo: emailValueLabel.bottomAnchor, constant: 20),
            nameCaptionLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),

            nameTextField.topAnchor.constraint(equalTo: nameCaptionLabel.bottomAnchor, constant: 12),
            nameTextField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),

            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 34),
            saveButton.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    @objc private func didTapSave() {
        delegate?.didTapSaveButton()
    }

    func configTextField(delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
    }

    func configure(name: String, email: String) {
        nameTextField.text = name
        emailValueLabel.text = email.isEmpty ? "—" : email
    }

    func setNameFieldBorderColor(_ color: CGColor) {
        nameTextField.layer.borderColor = color
    }

    func setSaveButtonEnabled(_ enabled: Bool) {
        saveButton.isEnabled = enabled
        saveButton.alpha = enabled ? 1.0 : 0.5
    }

    func setSaveButtonLoading(_ isLoading: Bool) {
        if isLoading {
            saveButton.setTitle("", for: .normal)
            saveButton.isEnabled = false
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.color = .white
            spinner.tag = 9999
            spinner.translatesAutoresizingMaskIntoConstraints = false
            saveButton.addSubview(spinner)
            NSLayoutConstraint.activate([
                spinner.centerXAnchor.constraint(equalTo: saveButton.centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            ])
            spinner.startAnimating()
        } else {
            saveButton.setTitle("Salvar", for: .normal)
            if let spinner = saveButton.viewWithTag(9999) as? UIActivityIndicatorView {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
        }
    }

    func setFieldsEnabled(_ enabled: Bool) {
        nameTextField.isEnabled = enabled
    }
}
