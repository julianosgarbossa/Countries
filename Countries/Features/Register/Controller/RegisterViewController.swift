//
//  RegisterViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class RegisterViewController: UIViewController {

    private var registerScreen: RegisterScreen?
    private let registerViewModel = RegisterViewModel()
    private let defaultBorderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationControler()
    }
    
    private func configProtocols() {
        registerScreen?.delegate(delegate: self)
        registerScreen?.configTextField(delegate: self)
        registerViewModel.delegate = self
    }
    
    private func configNavigationControler() {
        navigationController?.navigationBar.isHidden = false
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let registerScreen,
              let fieldTag = registerScreen.registerFieldType(for: textField) else { return true }

        let textAfterChange = (textField.text ?? "").applyingReplacement(range: range, with: string)

        switch fieldTag {
        case .name:
            registerViewModel.updateField(field: .name, value: textAfterChange)
        case .email:
            registerViewModel.updateField(field: .email, value: textAfterChange)
        case .password:
            registerViewModel.updateField(field: .password, value: textAfterChange)
        case .confirmPassword:
            registerViewModel.updateField(field: .confirmPassword, value: textAfterChange)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        registerScreen?.focusNextField(after: textField)
        return true
    }
}

extension RegisterViewController: RegisterScreenDelegate {
    func didTapRegisterButton() {
        registerViewModel.register()
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func didUpdateFormVaidity(isValid: Bool) {
        registerScreen?.setRegisterButtonEnabled(isValid)
    }
    
    func didValidateField(field: RegisterViewModel.RegisterFieldType, isValid: Bool) {
        guard let registerScreen else { return }
        
        let fieldTag: RegisterFieldTag
        switch field {
        case .name:
            fieldTag = .name
        case .email:
            fieldTag = .email
        case .password:
            fieldTag = .password
        case .confirmPassword:
            fieldTag = .confirmPassword
        }
        
        registerScreen.setFieldBorderColor(field: fieldTag, color: isValid ? defaultBorderColor : UIColor.red.cgColor)
    }
    
    func didRegisterSuccess() {
        // Integração futura com camada de serviço (Firebase Auth)
    }
}
