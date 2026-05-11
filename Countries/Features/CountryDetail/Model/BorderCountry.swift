//
//  BorderCountry.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 08/05/26.
//

import Foundation

struct BorderCountry: CountryDisplayable {
    let code: String
    let name: String
    let flagURL: String

    var cca2: String { code }
    var displayName: String { name }
}
