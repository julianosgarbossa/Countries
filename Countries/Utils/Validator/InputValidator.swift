//
//  InputValidator.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 13/04/26.
//

import Foundation

struct InputValidator {
    static func validateName(text: String?) -> Bool {
        guard let name = text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !name.isEmpty,
              name.count >= 2 else { return false }
        return true
    }
    
    static func validateEmail(text: String?) -> Bool {
        guard let email = text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !email.isEmpty else { return false }
        let regex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        return NSPredicate(format: "SELF MATCHES[c] %@", regex)
            .evaluate(with: email)
    }
    
    static func validatePassword(text: String?) -> Bool {
        guard let password = text, password.count >= 8 else { return false }
        return true
    }
    
    static func validateConfirmPassword(password: String?, confirmPassword: String?) -> Bool {
        guard let password, let confirmPassword, !confirmPassword.isEmpty else {
            return false
        }
        return password == confirmPassword
    }
}
