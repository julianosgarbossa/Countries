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
        let urlString = "https://restcountries.com/v3.1/alpha?codes=\(codes)&fields=cca3,name,flags"
        
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
                let borderCountries = try JSONDecoder().decode([BorderCountryResponse].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(borderCountries))
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
