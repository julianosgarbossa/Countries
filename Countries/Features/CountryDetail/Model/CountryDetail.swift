//
//  CountryDetail.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 08/05/26.
//

import Foundation

struct CountryDetail {
    let cca2: String
    let flag: String
    var isFavorited: Bool
    let countryName: String
    let continentName: String
    let area: String
    let borders: [String]
    let capital: String
    let population: String
    let coin: String
    let languages: [String: String]?
}
