//
//  FavoritesViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 15/04/26.
//

import Foundation

final class FavoritesViewModel {
    private var countryFavoriteList: [Country] = [Country(name: "Brasil",
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
                                                     isFavorited: true),
                                            Country(name: "Argentina",
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
                                                     isFavorited: true),
                                            Country(name: "Canadá",
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
                                                     isFavorited: true),
                                            Country(name: "Espanha",
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
                                                     isFavorited: true),
                                            Country(name: "Itália",
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
                                                     isFavorited: true),
                                            Country(name: "Japão",
                                                     capital: "Tokyo",
                                                     region: Region(name: "Leste Asiático"),
                                                     continent: Continent(name: "Ásia"),
                                                     area: "377.975",
                                                     borders: ["Nenhuma"],
                                                     languages: ["Japonês"],
                                                     population: "125.836.021",
                                                     coin: "¥",
                                                     flag: "jp",
                                                     isFavorited: true)
    ]
    
    var numberOfItemsInSection: Int {
        countryFavoriteList.count
    }
    
    func country(at index: Int) -> Country {
        return countryFavoriteList[index]
    }
}
