//
//  CountryDetailService.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 07/05/26.
//

import Foundation

final class CountryDetailService {
    
    static func fetchCountryDetail(countryId: String, completion: @escaping (Result<CountryDetailResponse, NetworkError>) -> Void ) {
        let urlString = "https://restcountries.com/v3.1/alpha/\(countryId)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL(url: urlString)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.networkFailure(error)))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.invalidResponse))
                }
                return
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.statusCode(code: httpResponse.statusCode)))
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            
            do {
                let countries = try JSONDecoder().decode([CountryDetailResponse].self, from: data)
                
                guard let countryDetail = countries.first else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.noData))
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(.success(countryDetail))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}
