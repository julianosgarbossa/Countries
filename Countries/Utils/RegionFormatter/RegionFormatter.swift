//
//  RegionFormatter.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 08/05/26.
//

import Foundation

enum RegionFormatter {
    
    static func title(for apiRegion: String) -> String {
        switch apiRegion {
        case "Africa":
            return "África"
        case "Americas":
            return "América"
        case "Asia":
            return "Ásia"
        case "Europe":
            return "Europa"
        case "Oceania":
            return "Oceania"
        case "Antarctic":
            return "Antártida"
        default:
            return apiRegion
        }
    }
}
