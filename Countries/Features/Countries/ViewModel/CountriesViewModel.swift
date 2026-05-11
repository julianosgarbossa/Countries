//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 14/04/26.
//

import Foundation

protocol CountriesViewModelProtocol: AnyObject {
    func countriesViewModelUpdateUI()
    func countriesViewModelDidChangeState(_ state: ViewState)
}

final class CountriesViewModel {
    
    weak var delegate: CountriesViewModelProtocol?
    
    private(set) var state: ViewState = .idle

    private var continents: [Continent] = []
    
    private var countries: [Country] = []
    private let favoritesRepository = FavoritesRepository.shared
    
    private var filteredCountries: [Country] = []
    private var currentSearchText: String = ""
    private var selectedContinentIndex: Int = 0
    private var hasLoadedCountries: Bool = false
    
    private func applyFilters() {
        var result = countries

        if let selectedRegion = continent(at: selectedContinentIndex).apiRegion {
            result = result.filter { $0.continent == selectedRegion }
        }

        let search = currentSearchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !search.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(search)
            }
        }

        filteredCountries = result
    }
    
    private func applyContinentSelection(oldIndex: Int, newIndex: Int) {
        continents[oldIndex].isSelected = false
        continents[newIndex].isSelected = true
    }
    
    var numberOfRowsInSection: Int {
        filteredCountries.count
    }
    
    var numberOfItemsInSection: Int {
        continents.count
    }
    
    var shouldShowEmptyState: Bool {
        hasLoadedCountries && filteredCountries.isEmpty
    }
    
    var emptyStateMessage: String {
        guard !continents.isEmpty else {
            return "Nenhum país encontrado."
        }
        
        if !currentSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Ops! Nenhum país chamado \(currentSearchText) foi encontrado, tente novamente!"
        }
        
        let selectedContinent = continent(at: selectedContinentIndex).name
        if selectedContinent != "Todas" {
            return "Nenhum país encontrado para o continente selecionado."
        }
        
        return "Nenhum país encontrado."
    }
    
    func country(at index: Int) -> Country {
        return filteredCountries[index]
    }
    
    func toggleFavorite(at index: Int) {
        let countryId = filteredCountries[index].cca2
        let isFavorite = favoritesRepository.toggle(countryId)
        updateFavoriteState(countryId: countryId, isFavorite: isFavorite)
    }
    
    func refreshFavoritesState() {
        guard !continents.isEmpty else { return }
        
        let favoriteIds = favoritesRepository.allIds()
        countries = countries.map { country in
            var country = country
            country.isFavorite = favoriteIds.contains(country.cca2)
            return country
        }
        applyFilters()
    }
    
    func continent(at index: Int) -> Continent {
        return continents[index]
    }
    
    func searchCountries(with text: String) {
        currentSearchText = text
        applyFilters()
    }
    
    func didSelectContinent(at index: Int) -> (oldIndex: Int, newIndex: Int)? {
        guard selectedContinentIndex != index else { return nil }
        
        let oldIndex = selectedContinentIndex
        selectedContinentIndex = index
        
        applyContinentSelection(oldIndex: oldIndex, newIndex: index)
        applyFilters()
        
        return (oldIndex, index)
    }
    
    func fetchCountries() {
        state = .loading
        delegate?.countriesViewModelDidChangeState(state)

        CountriesService.fetchCountries { [weak self] result  in
            guard let self else { return }
            switch result {
            case .success(let countriesResponse):
                self.hasLoadedCountries = true
                let favorites = favoritesRepository.allIds()
                countries = countriesResponse.map({ country in
                    let region = country.subregion.isEmpty ? "Não informada" : country.subregion
                    return Country(cca2: country.cca2,
                                capital: country.capital.first ?? "Não informada",
                                continent: country.region,
                                region: region,
                                name: country.name.common,
                                flag: country.flags.png,
                                isFavorite: favorites.contains(country.cca2))
                })
                
                let continents = Array(Set(countries.map { $0.continent })).sorted()

                self.continents = [Continent(name: "Todas", apiRegion: nil, isSelected: true)] +
                    continents.map { region in
                        Continent(
                            name: RegionFormatter.title(for: region),
                            apiRegion: region
                        )
                    }

                self.applyFilters()
                self.state = .loaded
                self.delegate?.countriesViewModelDidChangeState(self.state)
                self.delegate?.countriesViewModelUpdateUI()
            case .failure(let error):
                self.hasLoadedCountries = true
                self.state = .error(message: error.localizedDescription)
                self.delegate?.countriesViewModelDidChangeState(self.state)
                self.delegate?.countriesViewModelUpdateUI()
            }
        }
    }
    
    private func updateFavoriteState(countryId: String, isFavorite: Bool) {
        if let index = countries.firstIndex(where: { $0.cca2 == countryId }) {
            countries[index].isFavorite = isFavorite
        }
        
        if let index = filteredCountries.firstIndex(where: { $0.cca2 == countryId }) {
            filteredCountries[index].isFavorite = isFavorite
        }
    }
}
