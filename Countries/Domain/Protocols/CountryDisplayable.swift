//
//  CountryDisplayable.swift
//  Countries
//

import Foundation

protocol CountryDisplayable {
    var cca2: String { get }
    var displayName: String { get }
    var flagURL: String { get }
}
