//
//  BorderCountryResponse.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 08/05/26.
//

import Foundation

struct BorderCountryResponse: Codable {
    let cca3: String
    let name: CountryName
    let flags: CountryFlag
}

extension BorderCountryResponse {
    func toBorderCountry() -> BorderCountry {
        BorderCountry(
            code: cca3,
            name: name.common,
            flagURL: flags.png
        )
    }
}
