//
//  CountryDetailViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 15/04/26.
//

import Foundation

protocol CountryDetailViewModelDelegate: AnyObject {
    func countryDetailDidUpdate()
    func countryDetailDidChangeState(_ state: ViewState)
}

final class CountryDetailViewModel {
    
    weak var delegate: CountryDetailViewModelDelegate?
    
    private let countryId: String
    private let favoritesRepository = FavoritesRepository.shared
    private var countryDetail: CountryDetail?
    private var borderCountries: [BorderCountry] = []

    private(set) var state: ViewState = .idle
    
    init(countryId: String) {
        self.countryId = countryId
    }
    
    var countryDetailData: CountryDetail? {
        countryDetail
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
        guard let countryDetail else { return }
        
        let isFavorited = favoritesRepository.toggle(countryDetail.cca2)
        self.countryDetail?.isFavorited = isFavorited
        delegate?.countryDetailDidUpdate()
    }
    
    func fetchCountryDetail() {
        state = .loading
        delegate?.countryDetailDidChangeState(state)

        CountryDetailService.fetchCountryDetail(countryId: countryId) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                let detail = response.toCountryDetail(isFavorited: self.favoritesRepository.contains(response.cca2))
                self.countryDetail = detail
                self.borderCountries = []
                self.state = .loaded
                self.delegate?.countryDetailDidChangeState(self.state)
                self.delegate?.countryDetailDidUpdate()
                self.fetchBorderCountries(countryCodes: detail.borders)
            case .failure(let error):
                self.state = .error(message: error.localizedDescription)
                self.delegate?.countryDetailDidChangeState(self.state)
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
