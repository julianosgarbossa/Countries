//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 14/04/26.
//

import Foundation

final class CountriesViewModel {
    
    private var continentList: [Continent] = [Continent(name: "Todas", isSelected: true),
                                              Continent(name: "África"),
                                              Continent(name: "América"),
                                              Continent(name: "Ásia"),
                                              Continent(name: "Europa"),
                                              Continent(name: "Oceania"),
                                              Continent(name: "Antártida"),
    ]
    
    private var countrieList: [Countrie] = [Countrie(name: "Brasil",
                                                     capital: "Brasília",
                                                     region: Region(name: "América do Sul"),
                                                     continent: Continent(name: "América"),
                                                     area: "8.515.767",
                                                     borders: ["Argentina",
                                                               "Bolívia",
                                                               "Colômbia",
                                                               "Guiana",
                                                               "Guiana Francesa",
                                                               "Paraguai",
                                                               "Peru",
                                                               "Suriname",
                                                               "Uruguai",
                                                               "Venezuela"],
                                                     languages: ["Português"],
                                                     population: "213.421.037",
                                                     coin: "R$",
                                                     flag: "br",
                                                     isFavorited: false),
                                            Countrie(name: "Argentina",
                                                     capital: "Buenos Aires",
                                                     region: Region(name: "América do Sul"),
                                                     continent: Continent(name: "América"),
                                                     area: "2.780.400",
                                                     borders: ["Brasil",
                                                               "Chile",
                                                               "Paraguai",
                                                               "Bolívia",
                                                               "Uruguai"],
                                                     languages: ["Espanhol",
                                                                 "Guarani"],
                                                     population: "45.808.747",
                                                     coin: "$",
                                                     flag: "ar",
                                                     isFavorited: false),
                                            Countrie(name: "Canadá",
                                                     capital: "Ottawa",
                                                     region: Region(name: "América do Norte"),
                                                     continent: Continent(name: "América"),
                                                     area: "9.984.670",
                                                     borders: ["Estados Unidos"],
                                                     languages: ["Inglês",
                                                                 "Francês"],
                                                     population: "38.246.108",
                                                     coin: "$",
                                                     flag: "ca",
                                                     isFavorited: false),
                                            Countrie(name: "Espanha",
                                                     capital: "Madrid",
                                                     region: Region(name: "Europa Ocidental"),
                                                     continent: Continent(name: "Europa"),
                                                     area: "505.990",
                                                     borders: ["Portugal",
                                                               "França",
                                                               "Andorra",
                                                               "Marrocos"],
                                                     languages: ["Espanhol"],
                                                     population: "47.615.034",
                                                     coin: "€",
                                                     flag: "es",
                                                     isFavorited: false),
                                            Countrie(name: "Itália",
                                                     capital: "Roma",
                                                     region: Region(name: "Europa Meridional"),
                                                     continent: Continent(name: "Europa"),
                                                     area: "301.340",
                                                     borders: ["França",
                                                               "Suíça",
                                                               "Áustria",
                                                               "Eslovênia",
                                                               "San Marino",
                                                               "Vaticano"],
                                                     languages: ["Italiano"],
                                                     population: "58.870.762",
                                                     coin: "€",
                                                     flag: "it",
                                                     isFavorited: false),
                                            Countrie(name: "Japão",
                                                     capital: "Tokyo",
                                                     region: Region(name: "Leste Asiático"),
                                                     continent: Continent(name: "Ásia"),
                                                     area: "377.975",
                                                     borders: ["Nenhuma"],
                                                     languages: ["Japonês"],
                                                     population: "125.836.021",
                                                     coin: "¥",
                                                     flag: "jp",
                                                     isFavorited: false)
    ]
    
    private var filteredCountries: [Countrie] = []
    private var currentSearchText: String = ""
    private var selectedContinentIndex: Int = 0
    
    init() {
        self.filteredCountries = countrieList
    }
    
    private func applyFilters() {
        var result = countrieList
        
        let selectedContinent = continent(at: selectedContinentIndex).name
        
        if selectedContinent != "Todas" {
            result = result.filter { $0.continent.name == selectedContinent }
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
        continentList[oldIndex].isSelected = false
        continentList[newIndex].isSelected = true
    }
    
    var numberOfRowsInSection: Int {
        filteredCountries.count
    }
    
    var numberOfItemsInSection: Int {
        continentList.count
    }
    
    func country(at index: Int) -> Countrie {
        return filteredCountries[index]
    }
    
    func toggleFavorite(at index: Int) {
        filteredCountries[index].isFavorited.toggle()
    }
    
    func continent(at index: Int) -> Continent {
        return continentList[index]
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
}
