//
//  CountriesService.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 07/05/26.
//

import Foundation

final class CountriesService {

    private static let cacheKey = "countries_all"

    static func fetchCountries(completion: @escaping (Result<[CountryResponse], NetworkError>) -> Void) {
        if let cached = ResponseCache.shared.load([CountryResponse].self, forKey: cacheKey) {
            completion(.success(cached))
            return
        }

        let endpoint = Endpoint(
            path: "/all",
            queryItems: [
                URLQueryItem(name: "fields", value: "cca2,capital,region,subregion,name,flags")
            ]
        )

        APIClient.shared.request(endpoint, expecting: [CountryResponse].self) { result in
            if case .success(let countries) = result {
                ResponseCache.shared.save(countries, forKey: cacheKey)
            }
            completion(result)
        }
    }
}
