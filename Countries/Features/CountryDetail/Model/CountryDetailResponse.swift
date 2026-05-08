//
//  CountryDetailResponse.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 08/05/26.
//

import Foundation

struct CountryDetailResponse: Decodable {
    let cca2: String
    let name: CountryName
    let flags: CountryFlag
    let region: String
    let area: Double
    let borders: [String]?
    let capital: [String]?
    let population: Int
    let currencies: [String: CountryCurrency]?
    let languages: [String: String]?
}

struct CountryName: Decodable {
    let common: String
}

struct CountryFlag: Decodable {
    let png: String
}

struct CountryCurrency: Decodable {
    let name: String
    let symbol: String?
}

extension CountryDetailResponse {
    func toCountryDetail(isFavorited: Bool) -> CountryDetail {
        CountryDetail(
            cca2: cca2,
            flag: flags.png,
            isFavorited: isFavorited,
            countryName: name.common,
            continentName: RegionFormatter.title(for: region),
            area: "Área: \(formatNumber(area)) km²",
            borders: borders ?? [],
            capital: capital?.first ?? "Não informada",
            population: "\(formatNumber(population)) pessoas",
            coin: currencyText,
            languages: languages
        )
    }
    
    private var currencyText: String {
        guard let currency = currencies?.sorted(by: { $0.key < $1.key }).first?.value else {
            return "Não informada"
        }
        
        guard let symbol = currency.symbol, !symbol.isEmpty else {
            return currency.name
        }
        
        return "\(currency.name) (\(symbol))"
    }
    
    private func formatNumber(_ number: Int) -> String {
        NumberFormatter.localizedString(from: NSNumber(value: number), number: .decimal)
    }
    
    private func formatNumber(_ number: Double) -> String {
        NumberFormatter.localizedString(from: NSNumber(value: number), number: .decimal)
    }
}
