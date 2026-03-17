//
//  RegisterViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class RegisterViewController: UIViewController {

    private var registerScreen: RegisterScreen?
    private let defaultBorderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
        updateRegisterButtonState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationControler()
    }
    
    private func configProtocols() {
        registerScreen?.delegate(delegate: self)
        registerScreen?.configTextField(delegate: self)
    }
    
    private func configNavigationControler() {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func validateName(_ text: String?) -> Bool {
        guard let name = text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else { return false }
        return true
    }

    private func validateEmail(_ text: String?) -> Bool {
        guard let email = text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else { return false }
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return predicate.evaluate(with: email)
    }

    private func validatePassword(_ text: String?) -> Bool {
        guard let password = text, !password.isEmpty, password.count >= 8 else { return false }
        return true
    }

    private func validateConfirmPassword(password: String?, confirmPassword: String?) -> Bool {
        guard let password, let confirmPassword, !confirmPassword.isEmpty else { return false }
        return password == confirmPassword
    }

    private func isFormValid(name: String?,email: String?, password: String?, confirmPassword: String?) -> Bool {
        return validateName(name) && validateEmail(email) && validatePassword(password) && validateConfirmPassword(password: password, confirmPassword: confirmPassword)
    }

    private func isFormValid() -> Bool {
        guard let registerScreen else { return false }
        return isFormValid(name: registerScreen.nameTextField.text, email: registerScreen.emailTextField.text, password: registerScreen.passwordTextField.text, confirmPassword: registerScreen.confirmPasswordTextField.text)
    }

    private func applyFieldStyle(_ textField: UITextField, isValid: Bool) {
        textField.layer.borderColor = isValid ? defaultBorderColor : UIColor.red.cgColor
    }

    private func updateRegisterButtonState() {
        registerScreen?.setRegisterButtonEnabled(isFormValid())
    }

    private func textAfterChange(in textField: UITextField, range: NSRange, replacementString string: String) -> String {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return currentText
        }
        return currentText.replacingCharacters(in: stringRange, with: string)
    }

    private func validateAndStyleField(_ textField: UITextField, textOverride: String? = nil) {
        guard let registerScreen else { return }

        switch textField {
        case registerScreen.nameTextField:
            applyFieldStyle(textField, isValid: validateName(textOverride ?? textField.text))
        case registerScreen.emailTextField:
            applyFieldStyle(textField, isValid: validateEmail(textOverride ?? textField.text))
        case registerScreen.passwordTextField:
            applyFieldStyle(textField, isValid: validatePassword(textOverride ?? textField.text))
        case registerScreen.confirmPasswordTextField:
            let passwordValue = registerScreen.passwordTextField.text
            let confirmValue = textOverride ?? textField.text
            applyFieldStyle(textField, isValid: validateConfirmPassword(password: passwordValue, confirmPassword: confirmValue))
        default:
            break
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let registerScreen else { return true }

        let updatedText = textAfterChange(in: textField, range: range, replacementString: string)
        validateAndStyleField(textField, textOverride: updatedText)

        if textField == registerScreen.passwordTextField,
            let confirmPassword = registerScreen.confirmPasswordTextField.text,
            !confirmPassword.isEmpty {
            validateAndStyleField(registerScreen.confirmPasswordTextField)
        }
        
        let name = textField == registerScreen.nameTextField ? updatedText : registerScreen.nameTextField.text
        let email = textField == registerScreen.emailTextField ? updatedText : registerScreen.emailTextField.text
        let password = textField == registerScreen.passwordTextField ? updatedText : registerScreen.passwordTextField.text
        let confirmPassword = textField == registerScreen.confirmPasswordTextField ? updatedText : registerScreen.confirmPasswordTextField.text
        
        let formIsValid = isFormValid(name: name, email: email, password: password, confirmPassword: confirmPassword)
        registerScreen.setRegisterButtonEnabled(formIsValid)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        validateAndStyleField(textField)
        updateRegisterButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let registerScreen else { return true }

        switch textField {
        case registerScreen.nameTextField:
            registerScreen.emailTextField.becomeFirstResponder()
        case registerScreen.emailTextField:
            registerScreen.passwordTextField.becomeFirstResponder()
        case registerScreen.passwordTextField:
            registerScreen.confirmPasswordTextField.becomeFirstResponder()
        case registerScreen.confirmPasswordTextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

extension RegisterViewController: RegisterScreenDelegate {
    func didTapRegisterButton() {
        print("Registrando...")
    }
}
