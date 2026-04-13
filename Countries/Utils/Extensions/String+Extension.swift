//
//  String+Extension.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 13/04/26.
//

import Foundation

extension String {
    
    /// Retorna uma nova `String` aplicando a substituição de caracteres com base
    /// em um `NSRange`, geralmente utilizado nos delegates de `UITextField` e
    /// `UITextView`. Caso a conversão do intervalo falhe, o texto original é retornado.
    func applyingReplacement(range: NSRange, with string: String) -> String {
        guard let stringRange = Range(range, in: self) else {
            return self
        }
        return self.replacingCharacters(in: stringRange, with: string)
    }
}
