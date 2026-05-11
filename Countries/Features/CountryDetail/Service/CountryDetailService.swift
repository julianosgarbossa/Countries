//
//  CountryDetailService.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 07/05/26.
//

import Foundation

final class CountryDetailService {

    static func fetchCountryDetail(countryId: String, completion: @escaping (Result<CountryDetailResponse, NetworkError>) -> Void) {
        let cacheKey = "country_detail_\(countryId)"

        if let cached = ResponseCache.shared.load(CountryDetailResponse.self, forKey: cacheKey) {
            completion(.success(cached))
            return
        }

        let endpoint = Endpoint(
            path: "/alpha/\(countryId)",
            queryItems: []
        )

        APIClient.shared.request(endpoint, expecting: [CountryDetailResponse].self) { result in
            switch result {
            case .success(let list):
                guard let first = list.first else {
                    completion(.failure(.noData))
                    return
                }
                ResponseCache.shared.save(first, forKey: cacheKey)
                completion(.success(first))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
