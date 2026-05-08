//
//  CountriesService.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 07/05/26.
//

import Foundation

final class CountriesService {
    
    static func fetchCountries(completion: @escaping (Result<[CountryResponse], NetworkError>) -> Void ) {
        let urlString = "https://restcountries.com/v3.1/all?fields=cca2,capital,region,subregion,name,flags"
        
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
                let countries = try JSONDecoder().decode([CountryResponse].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(countries))
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
