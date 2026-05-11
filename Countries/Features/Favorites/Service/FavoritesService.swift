//
//  FavoritesService.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 08/05/26.
//

import Foundation

final class FavoritesService {

    static func fetchFavoriteCountries(countryIds: [String], completion: @escaping (Result<[CountryResponse], NetworkError>) -> Void) {
        let codes = countryIds.joined(separator: ",")
        let endpoint = Endpoint(
            path: "/alpha",
            queryItems: [
                URLQueryItem(name: "codes", value: codes),
                URLQueryItem(name: "fields", value: "cca2,capital,region,subregion,name,flags")
            ]
        )
        APIClient.shared.request(endpoint, expecting: [CountryResponse].self, completion: completion)
    }
}
