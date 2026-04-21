//
//  ChangePasswordScreen.swift
//  Countries
//
//  Created by Marcelo Araujo on 20/04/26.
//

import UIKit

protocol ChangePasswordScreenDelegate: AnyObject {
    func didTapSaveButton()
}

enum ChangePasswordFieldTag: Int {
    case current = 310
    case new = 311
    case confirm = 312
}

final class ChangePasswordScreen: UIView {

    private weak var delegate: ChangePasswordScreenDelegate?

    func delegate(delegate: ChangePasswordScreenDelegate) {
        self.delegate = delegate
    }

    /// Mesmo padrão visual de `EditProfileScreen`: branco com cantos superiores arredondados.
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 48
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        scroll.alwaysBounceVertical = true
        scroll.keyboardDismissMode = .interactive
        scroll.backgroundColor = .clear
        return scroll
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Alterar Senha"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Informe sua senha atual e escolha uma nova senha com pelo menos 8 caracteres."
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var currentPasswordLabel: UILabel = {
        makeCaptionLabel(text: "Senha atual")
    }()

    private lazy var currentPasswordTextField: UITextField = {
        makeSecureField(placeholder: "Senha atual", tag: .current)
    }()

    private lazy var newPasswordLabel: UILabel = {
        makeCaptionLabel(text: "Nova senha")
    }()

    private lazy var newPasswordTextField: UITextField = {
        makeSecureField(placeholder: "Nova senha", tag: .new)
    }()

    private lazy var confirmPasswordLabel: UILabel = {
        makeCaptionLabel(text: "Confirmar nova senha")
    }()

    private lazy var confirmPasswordTextField: UITextField = {
        makeSecureField(placeholder: "Repita a nova senha", tag: .confirm)
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Salvar nova senha", for: .normal)
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

    private lazy var bottomSpacer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
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
        cardView.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(currentPasswordLabel)
        containerView.addSubview(currentPasswordTextField)
        containerView.addSubview(newPasswordLabel)
        containerView.addSubview(newPasswordTextField)
        containerView.addSubview(confirmPasswordLabel)
        containerView.addSubview(confirmPasswordTextField)
        containerView.addSubview(saveButton)
        containerView.addSubview(bottomSpacer)

        let padding = CGFloat(16)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: cardView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            containerView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),

            currentPasswordLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            currentPasswordLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            currentPasswordLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),

            currentPasswordTextField.topAnchor.constraint(equalTo: currentPasswordLabel.bottomAnchor, constant: 12),
            currentPasswordTextField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            currentPasswordTextField.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            currentPasswordTextField.heightAnchor.constraint(equalToConstant: 48),

            newPasswordLabel.topAnchor.constraint(equalTo: currentPasswordTextField.bottomAnchor, constant: 16),
            newPasswordLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),

            newPasswordTextField.topAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor, constant: 12),
            newPasswordTextField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            newPasswordTextField.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            newPasswordTextField.heightAnchor.constraint(equalToConstant: 48),

            confirmPasswordLabel.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: 16),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),

            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 12),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 48),

            saveButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 34),
            saveButton.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 48),

            bottomSpacer.topAnchor.constraint(equalTo: saveButton.bottomAnchor),
            bottomSpacer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomSpacer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomSpacer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomSpacer.heightAnchor.constraint(greaterThanOrEqualToConstant: 24),
        ])
    }

    private func makeCaptionLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }

    private func makeSecureField(placeholder: String, tag: ChangePasswordFieldTag) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
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
        textField.isSecureTextEntry = true
        textField.returnKeyType = .next
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.tag = tag.rawValue
        return textField
    }

    @objc private func didTapSave() {
        delegate?.didTapSaveButton()
    }

    func configTextField(delegate: UITextFieldDelegate) {
        currentPasswordTextField.delegate = delegate
        newPasswordTextField.delegate = delegate
        confirmPasswordTextField.delegate = delegate
    }

    func fieldType(for textField: UITextField) -> ChangePasswordFieldTag? {
        ChangePasswordFieldTag(rawValue: textField.tag)
    }

    func setFieldBorderColor(field: ChangePasswordFieldTag, color: CGColor) {
        switch field {
        case .current:
            currentPasswordTextField.layer.borderColor = color
        case .new:
            newPasswordTextField.layer.borderColor = color
        case .confirm:
            confirmPasswordTextField.layer.borderColor = color
        }
    }

    func focusNextField(after textField: UITextField) {
        switch ChangePasswordFieldTag(rawValue: textField.tag) {
        case .current:
            newPasswordTextField.becomeFirstResponder()
        case .new:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
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
            saveButton.setTitle("Salvar nova senha", for: .normal)
            if let spinner = saveButton.viewWithTag(9999) as? UIActivityIndicatorView {
                spinner.stopAnimating()
                spinner.removeFromSuperview()
            }
        }
    }

    func setFieldsEnabled(_ enabled: Bool) {
        currentPasswordTextField.isEnabled = enabled
        newPasswordTextField.isEnabled = enabled
        confirmPasswordTextField.isEnabled = enabled
    }

    func ensureTextFieldVisible(_ textField: UITextField) {
        let margin: CGFloat = 20
        let rect = textField.convert(textField.bounds.insetBy(dx: 0, dy: -margin), to: scrollView)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
}
