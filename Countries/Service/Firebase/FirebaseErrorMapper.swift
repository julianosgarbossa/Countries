//
//  FirebaseErrorMapper.swift
//  Countries
//
//  Created by Marcelo Araujo on 15/04/26.
//

import Foundation
import FirebaseAuth

struct FirebaseErrorMapper {

    static func message(for error: Error) -> String {
        guard let authError = error as? NSError,
              authError.domain == AuthErrorDomain else {
            return error.localizedDescription
        }

        switch AuthErrorCode(rawValue: authError.code) {
        case .invalidEmail:
            return "O e-mail informado é inválido."
        case .emailAlreadyInUse:
            return "Este e-mail já está em uso por outra conta."
        case .weakPassword:
            return "A senha é muito fraca. Use pelo menos 6 caracteres."
        case .wrongPassword, .invalidCredential:
            return "E-mail ou senha incorretos."
        case .userNotFound:
            return "Nenhuma conta encontrada com este e-mail."
        case .userDisabled:
            return "Esta conta foi desativada."
        case .tooManyRequests:
            return "Muitas tentativas. Aguarde alguns minutos e tente novamente."
        case .networkError:
            return "Erro de conexão. Verifique sua internet e tente novamente."
        case .requiresRecentLogin:
            return "Por segurança, faça login novamente e tente de novo."
        default:
            return error.localizedDescription
        }
    }
}
