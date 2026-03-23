//
//  CountriesViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class CountriesViewController: UIViewController {
    
    private var countriesScreen: CountriesScreen?
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
                                                     population: "213.421.037",
                                                     coin: "R$",
                                                     flag: "br",
                                                     isFavorited: false),
                                            Countrie(name: "Argentina",
                                                    capital: "Buenos Aires",
                                                     region: Region(name: "América do Sul"),
                                                     continent: Continent(name: "América"),
                                                     area: "2.780.400",
                                                     population: "45.808.747",
                                                     coin: "$",
                                                     flag: "ar",
                                                     isFavorited: false),
                                            Countrie(name: "Canadá",
                                                     capital: "Ottawa",
                                                     region: Region(name: "América do Norte"),
                                                     continent: Continent(name: "América"),
                                                     area: "9.984.670",
                                                     population: "38.246.108",
                                                     coin: "$",
                                                     flag: "ca",
                                                     isFavorited: false),
                                            Countrie(name: "Espanha",
                                                     capital: "Madrid",
                                                     region: Region(name: "Europa Ocidental"),
                                                     continent: Continent(name: "Europa"),
                                                     area: "505.990",
                                                     population: "47.615.034",
                                                     coin: "€",
                                                     flag: "es",
                                                     isFavorited: false),
                                            Countrie(name: "Itália",
                                                     capital: "Roma",
                                                     region: Region(name: "Europa Meridional"),
                                                     continent: Continent(name: "Europa"),
                                                     area: "301.340",
                                                     population: "58.870.762",
                                                     coin: "€",
                                                     flag: "it",
                                                     isFavorited: false),
                                            Countrie(name: "Japão",
                                                     capital: "Tokyo",
                                                     region: Region(name: "Leste Asiático"),
                                                     continent: Continent(name: "Ásia"),
                                                     area: "377.975",
                                                     population: "125.836.021",
                                                     coin: "¥",
                                                     flag: "jp",
                                                     isFavorited: false)
    ]
    
    private var selectedIndex: Int = 0
    
    override func loadView() {
        countriesScreen = CountriesScreen()
        view = countriesScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationControler()
    }
    
    private func configNavigationControler() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configProtocols() {
        countriesScreen?.configSearchBar(delegate: self)
        countriesScreen?.configCollectionView(delegate: self, dataSource: self)
        countriesScreen?.configTableView(delegate: self, dataSource: self)
    }
}

extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension CountriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedIndex != indexPath.item else { return }
        
        let previousIndexPath = IndexPath(item: selectedIndex, section: indexPath.section)
        
        continentList[selectedIndex].isSelected = false
        continentList[indexPath.item].isSelected = true
        selectedIndex = indexPath.item
        
        collectionView.reloadItems(at: [previousIndexPath, indexPath])
    }
}

extension CountriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return continentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContinentCollectionViewCell.identifier, for: indexPath) as? ContinentCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(continent: continentList[indexPath.item])
        return cell
    }
}

extension CountriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ContinentCollectionViewCell.calculateSize(title: continentList[indexPath.item].name)
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countrieDetailViewController = CountrieDetailViewController(countrie: countrieList[indexPath.row])
        navigationController?.pushViewController(countrieDetailViewController, animated: true)
    }
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countrieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountrieTableViewCell.identifier, for: indexPath) as? CountrieTableViewCell else { return UITableViewCell() }
        cell.setupCell(countrie: countrieList[indexPath.row])
        cell.delegate(delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(106)
    }
}

extension CountriesViewController: CountrieTableViewCellDelegate {
    func countryCellDidTapFavorite(cell: CountrieTableViewCell) {
        guard let indexPath = countriesScreen?.countriesTableView.indexPath(for: cell) else { return }
        countrieList[indexPath.row].isFavorited.toggle()
        countriesScreen?.countriesTableView.reloadRows(at: [indexPath], with: .none)
    }
}
