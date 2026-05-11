//
//  FavoritesLocalStorage.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 08/05/26.
//

import Foundation

final class FavoritesLocalStorage {
    
    static let shared = FavoritesLocalStorage()
    
    private let userDefaults: UserDefaults
    private let favoritesKey = "favorite_country_ids"
    
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func allIds() -> Set<String> {
        let ids = userDefaults.stringArray(forKey: favoritesKey) ?? []
        return Set(ids)
    }
    
    func contains(_ countryId: String) -> Bool {
        allIds().contains(normalized(countryId))
    }
    
    func add(_ countryId: String) {
        var ids = allIds()
        ids.insert(normalized(countryId))
        save(ids)
    }
    
    func remove(_ countryId: String) {
        var ids = allIds()
        ids.remove(normalized(countryId))
        save(ids)
    }
    
    @discardableResult
    func toggle(_ countryId: String) -> Bool {
        let countryId = normalized(countryId)
        var ids = allIds()
        
        if ids.contains(countryId) {
            ids.remove(countryId)
            save(ids)
            return false
        }
        
        ids.insert(countryId)
        save(ids)
        return true
    }
    
    private func save(_ ids: Set<String>) {
        userDefaults.set(Array(ids).sorted(), forKey: favoritesKey)
    }
    
    private func normalized(_ countryId: String) -> String {
        countryId.uppercased()
    }
}
