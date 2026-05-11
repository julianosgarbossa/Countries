//
//  BorderCountriesService.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 08/05/26.
//

import Foundation

final class BorderCountriesService {

    static func fetchBorderCountries(countryCodes: [String], completion: @escaping (Result<[BorderCountryResponse], NetworkError>) -> Void) {
        let codes = countryCodes.joined(separator: ",")
        let endpoint = Endpoint(
            path: "/alpha",
            queryItems: [
                URLQueryItem(name: "codes", value: codes),
                URLQueryItem(name: "fields", value: "cca3,name,flags")
            ]
        )
        APIClient.shared.request(endpoint, expecting: [BorderCountryResponse].self, completion: completion)
    }
}
