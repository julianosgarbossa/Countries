//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 14/04/26.
//

import Foundation

protocol CountriesViewModelProtocol: AnyObject {
    func countriesViewModelUpdateUI()
}

final class CountriesViewModel {
    
    weak var delegate: CountriesViewModelProtocol?
    
    private var continents: [Continent] = []
    
    private var countries: [Country] = []
    private var favorites: Set<String> = ["BR", "AR", "IT", "AI"]
    
    private var filteredCountries: [Country] = []
    private var currentSearchText: String = ""
    private var selectedContinentIndex: Int = 0
    
    // Aplica os filtros atuais de continente e busca sobre a lista completa de paises.
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
    
    // Atualiza o estado visual de selecao dos filtros de continente.
    private func applyContinentSelection(oldIndex: Int, newIndex: Int) {
        continents[oldIndex].isSelected = false
        continents[newIndex].isSelected = true
    }
    
    // Retorna a quantidade de paises que a tabela deve exibir apos os filtros.
    var numberOfRowsInSection: Int {
        filteredCountries.count
    }
    
    // Retorna a quantidade de continentes que a collection view de filtros deve exibir.
    var numberOfItemsInSection: Int {
        continents.count
    }
    
    // Indica se a tela deve mostrar a mensagem de lista vazia.
    var shouldShowEmptyState: Bool {
        filteredCountries.isEmpty
    }
    
    // Define a mensagem de estado vazio com base no filtro ou texto de busca atual.
    var emptyStateMessage: String {
        if !currentSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Ops! Nenhum país chamado \(currentSearchText) foi encontrado, tente novamente!"
        }
        
        let selectedContinent = continent(at: selectedContinentIndex).name
        if selectedContinent != "Todas" {
            return "Nenhum país encontrado para o continente selecionado."
        }
        
        return "Nenhum país encontrado."
    }
    
    // Retorna o pais filtrado na posicao informada para configurar a celula ou detalhe.
    func country(at index: Int) -> Country {
        return filteredCountries[index]
    }
    
    // Alterna o estado de favorito do pais exibido na posicao informada.
    func toggleFavorite(at index: Int) {
        filteredCountries[index].isFavorite.toggle()
    }
    
    // Retorna o continente na posicao informada para configurar a celula de filtro.
    func continent(at index: Int) -> Continent {
        return continents[index]
    }
    
    // Guarda o texto digitado na busca e reaplica os filtros da lista.
    func searchCountries(with text: String) {
        currentSearchText = text
        applyFilters()
    }
    
    // Seleciona um continente, reaplica os filtros e informa quais celulas precisam ser recarregadas.
    func didSelectContinent(at index: Int) -> (oldIndex: Int, newIndex: Int)? {
        guard selectedContinentIndex != index else { return nil }
        
        let oldIndex = selectedContinentIndex
        selectedContinentIndex = index
        
        applyContinentSelection(oldIndex: oldIndex, newIndex: index)
        applyFilters()
        
        return (oldIndex, index)
    }
    
    // Busca os paises na API, converte a resposta para o modelo da tela e monta os filtros de continente.
    func fetchCountries() {
        CountriesService.fetchCountries { [weak self] result  in
            guard let self else { return }
            switch result {
            case .success(let countriesResponse):
                let favorites = favorites
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
                
                self.delegate?.countriesViewModelUpdateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
}
