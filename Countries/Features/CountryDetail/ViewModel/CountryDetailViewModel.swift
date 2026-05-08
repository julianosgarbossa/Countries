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
    
    private let countryId: String
    private var countryDetail: CountryDetail?
    private var borderCountries: [BorderCountry] = []
    
    init(countryId: String) {
        self.countryId = countryId
    }
    
    var countryDetailData: CountryDetail {
        countryDetail ?? CountryDetail(
            cca2: countryId,
            flag: "",
            isFavorited: false,
            countryName: "Carregando...",
            continentName: "-",
            area: "Área: -",
            borders: [],
            capital: "-",
            population: "-",
            coin: "-",
            languages: nil
        )
    }
    
    var languagesCount: Int {
        return languages.count
    }
    
    var bordersCount: Int {
        return borderCountries.count
    }

    func language(at index: Int) -> String {
        return languages[index]
    }

    func border(at index: Int) -> String {
        return borderCountries[index].name
    }
    
    func borderCountry(at index: Int) -> BorderCountry {
        return borderCountries[index]
    }
    
    func didTapFavorite() {
        countryDetail?.isFavorited.toggle()
        delegate?.countryDetailDidUpdate()
    }
    
    func fetchCountryDetail() {
        CountryDetailService.fetchCountryDetail(countryId: countryId) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                let detail = response.toCountryDetail(isFavorited: false)
                self.countryDetail = detail
                self.borderCountries = []
                self.delegate?.countryDetailDidUpdate()
                self.fetchBorderCountries(countryCodes: detail.borders)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchBorderCountries(countryCodes: [String]) {
        guard !countryCodes.isEmpty else {
            borderCountries = [
                BorderCountry(code: "", name: "Não possui", flagURL: "")
            ]
            delegate?.countryDetailDidUpdate()
            return
        }
        
        BorderCountriesService.fetchBorderCountries(countryCodes: countryCodes) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                self.borderCountries = response
                    .map { $0.toBorderCountry() }
                    .sorted { $0.name < $1.name }
            case .failure(let error):
                print(error)
                self.borderCountries = countryCodes.map {
                    BorderCountry(code: $0, name: $0, flagURL: "")
                }
            }
            
            self.delegate?.countryDetailDidUpdate()
        }
    }
    
    private var languages: [String] {
        guard let languages = countryDetail?.languages?.values.sorted() else { return [] }
        
        return languages.isEmpty ? ["Não informada"] : languages
    }
}
