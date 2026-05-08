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
        return borders.count
    }

    func language(at index: Int) -> String {
        return languages[index]
    }

    func border(at index: Int) -> String {
        return borders[index]
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
                print(detail)
                self.delegate?.countryDetailDidUpdate()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private var languages: [String] {
        guard let languages = countryDetail?.languages?.values.sorted() else { return [] }
        
        return languages.isEmpty ? ["Não informada"] : languages
    }
    
    private var borders: [String] {
        guard let borders = countryDetail?.borders else { return [] }
        
        return borders.isEmpty ? ["Não informada"] : borders
    }
}
