//
//  CountryDetailViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 15/04/26.
//

import Foundation

protocol CountryDetailViewModelDelegate: AnyObject {
    func countryDetailDidUpdate()
}

final class CountryDetailViewModel {
    
    weak var delegate: CountryDetailViewModelDelegate?
    
    private var country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    var countryDetailData: CountryDetailData {
        CountryDetailData(flagName: country.flag,
                          isFavorited: country.isFavorited,
                          countryName: country.name,
                          continentName: country.continent.name,
                          areaText: "Área: \(country.area) km²",
                          capitalText: country.capital,
                          populationText: "\(country.population) pessoas",
                          coinText: country.coin)
    }
    
    var languagesCount: Int {
        country.languages.count
    }
    
    var bordersCount: Int {
        country.borders.count
    }

    func language(at index: Int) -> String {
        country.languages[index]
    }

    func border(at index: Int) -> String {
        country.borders[index]
    }
    
    func didTapFavorite() {
        country.isFavorited.toggle()
        delegate?.countryDetailDidUpdate()
        // salvar isso em algum lugar banco/userdefaults...
    }
}
