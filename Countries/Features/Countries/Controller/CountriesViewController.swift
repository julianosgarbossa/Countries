//
//  CountriesViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class CountriesViewController: UIViewController {
    
    private var countriesScreen: CountriesScreen?
    private var regionList: [Region] = [Region(name: "Todas", isSelected: true),
                                        Region(name: "África"),
                                        Region(name: "América"),
                                        Region(name: "Ásia"),
                                        Region(name: "Europa"),
                                        Region(name: "Oceania"),
                                        Region(name: "Antártida"),
    ]
    private var countrieList: [Countrie] = [Countrie(name: "Brasil",
                                                     capital: "Brasília",
                                                     region: Region(name: "América"),
                                                     flag: "br",
                                                     isFavorited: false),
                                            Countrie(name: "Argentina",
                                                      capital: "Buenos Aires",
                                                      region: Region(name: "América"),
                                                      flag: "ar",
                                                      isFavorited: false),
                                            Countrie(name: "Canadá",
                                                      capital: "Ottawa",
                                                      region: Region(name: "América"),
                                                      flag: "ca",
                                                      isFavorited: false),
                                            Countrie(name: "Espanha",
                                                      capital: "Madrid",
                                                      region: Region(name: "Europa"),
                                                      flag: "es",
                                                      isFavorited: false),
                                            Countrie(name: "Itália",
                                                      capital: "Roma",
                                                      region: Region(name: "Europa"),
                                                      flag: "it",
                                                      isFavorited: false),
                                            Countrie(name: "Japão",
                                                      capital: "Tokyo",
                                                      region: Region(name: "Ásia"),
                                                      flag: "jp",
                                                      isFavorited: false),
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
        
        regionList[selectedIndex].isSelected = false
        regionList[indexPath.item].isSelected = true
        selectedIndex = indexPath.item
        
        collectionView.reloadItems(at: [previousIndexPath, indexPath])
    }
}

extension CountriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegionCollectionViewCell.identifier, for: indexPath) as? RegionCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(region: regionList[indexPath.item])
        return cell
    }
}

extension CountriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return RegionCollectionViewCell.calculateSize(title: regionList[indexPath.item].name)
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Navegar para tela de detalhes do país: \(countrieList[indexPath.row].name)")
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
