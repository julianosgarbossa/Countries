//
//  CountryResponse.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 07/05/26.
//

import Foundation

struct CountryResponse: Codable, CountryDisplayable {
    let cca2: String
    let capital: [String]
    let region: String
    let subregion: String
    let name: Name
    let flags: Flags

    var displayName: String { name.common }
    var flagURL: String { flags.png }
}

struct Name: Codable {
    let common: String
}

struct Flags: Codable {
    let png: String
}
