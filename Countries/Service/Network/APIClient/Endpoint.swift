//
//  Endpoint.swift
//  Countries
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]

    static let baseURL = "https://restcountries.com/v3.1"

    var url: URL? {
        var components = URLComponents(string: Self.baseURL + path)
        if !queryItems.isEmpty {
            components?.queryItems = queryItems
        }
        return components?.url
    }
}
