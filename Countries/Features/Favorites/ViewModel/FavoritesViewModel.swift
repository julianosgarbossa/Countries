//
//  FavoritesViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 15/04/26.
//

import Foundation

final class FavoritesViewModel {
    
    private let favoritesRepository = FavoritesRepository.shared
    private var favoriteCountries: [Country] = []

    private(set) var state: ViewState = .idle
    
    var numberOfItemsInSection: Int {
        favoriteCountries.count
    }
    
    var shouldShowEmptyState: Bool {
        favoriteCountries.isEmpty
    }
    
    var emptyStateMessage: String {
        "Nenhum país favorito ainda."
    }
    
    func countryIfAvailable(at index: Int) -> Country? {
        guard favoriteCountries.indices.contains(index) else { return nil }
        
        return favoriteCountries[index]
    }
    
    func fetchFavorites(completion: @escaping () -> Void) {
        let favoriteIds = Array(favoritesRepository.allIds()).sorted()
        let favoriteIdsSet = Set(favoriteIds)
        let previousVisibleIds = Set(favoriteCountries.map { $0.cca2 })
        
        favoriteCountries = favoriteCountries.filter {
            favoriteIdsSet.contains($0.cca2)
        }
        
        let currentVisibleIds = Set(favoriteCountries.map { $0.cca2 })
        let didUpdateVisibleList = previousVisibleIds != currentVisibleIds
        
        if didUpdateVisibleList {
            completion()
        }
        
        guard !favoriteIds.isEmpty else {
            favoriteCountries = []
            state = .empty(message: emptyStateMessage)
            
            if !didUpdateVisibleList {
                completion()
            }
            return
        }

        state = .loading
        
        FavoritesService.fetchFavoriteCountries(countryIds: favoriteIds) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let countriesResponse):
                let currentFavoriteIds = self.favoritesRepository.allIds()
                
                self.favoriteCountries = countriesResponse
                    .filter { currentFavoriteIds.contains($0.cca2) }
                    .map { country in
                        let region = country.subregion.isEmpty ? "Não informada" : country.subregion
                        return Country(
                            cca2: country.cca2,
                            capital: country.capital.first ?? "Não informada",
                            continent: country.region,
                            region: region,
                            name: country.name.common,
                            flag: country.flags.png,
                            isFavorite: true
                        )
                    }
                    .sorted { $0.name < $1.name }
                self.state = self.favoriteCountries.isEmpty ? .empty(message: self.emptyStateMessage) : .loaded
            case .failure(let error):
                print(error)
                self.favoriteCountries = []
                self.state = .error(message: error.localizedDescription)
            }
            
            completion()
        }
    }
}
