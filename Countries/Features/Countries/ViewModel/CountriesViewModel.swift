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
    
    init() {
        self.filteredCountries = countrieList
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
        let searchText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !searchText.isEmpty else {
            filteredCountries = countrieList
            return
        }
        
        filteredCountries = countrieList.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}
