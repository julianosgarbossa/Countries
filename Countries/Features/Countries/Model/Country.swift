//
//  Country.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 07/05/26.
//

import Foundation

struct Country: CountryDisplayable {
    let cca2: String
    let capital: String
    let continent: String
    let region: String
    let name: String
    let flag: String
    var isFavorite: Bool = false

    var displayName: String { name }
    var flagURL: String { flag }
}
