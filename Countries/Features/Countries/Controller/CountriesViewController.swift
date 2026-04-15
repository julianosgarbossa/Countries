//
//  CountriesViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class CountriesViewController: UIViewController {
    
    private var countriesScreen: CountriesScreen?
    private let countriesViewModel = CountriesViewModel()
    
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
    
    private func updateCountriesListUI() {
        countriesScreen?.countriesTableView.reloadData()
        
        if countriesViewModel.shouldShowEmptyState {
            countriesScreen?.showEmptyState(message: countriesViewModel.emptyStateMessage)
        } else {
            countriesScreen?.hideEmptyState()
        }
    }
}

extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        countriesViewModel.searchCountries(with: searchText)
        updateCountriesListUI()
    }
}

extension CountriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let update = countriesViewModel.didSelectContinent(at: indexPath.item) else { return }
         
         let oldIndexPath = IndexPath(item: update.oldIndex, section: indexPath.section)
         let newIndexPath = IndexPath(item: update.newIndex, section: indexPath.section)
         
         collectionView.reloadItems(at: [oldIndexPath, newIndexPath])
         updateCountriesListUI()
    }
}

extension CountriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countriesViewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContinentCollectionViewCell.identifier, for: indexPath) as? ContinentCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(continent: countriesViewModel.continent(at: indexPath.item))
        return cell
    }
}

extension CountriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let continent = countriesViewModel.continent(at: indexPath.item)
        return ContinentCollectionViewCell.calculateSize(title: continent.name)
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countrieDetailViewController = CountryDetailViewController(country: countriesViewModel.country(at: indexPath.row))
        navigationController?.pushViewController(countrieDetailViewController, animated: true)
    }
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountrieTableViewCell.identifier, for: indexPath) as? CountrieTableViewCell else { return UITableViewCell() }
        cell.setupCell(countrie: countriesViewModel.country(at: indexPath.row))
        cell.delegate(delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CountrieTableViewCell.heightForRowAt
    }
}

extension CountriesViewController: CountrieTableViewCellDelegate {
    func countryCellDidTapFavorite(cell: CountrieTableViewCell) {
        guard let indexPath = countriesScreen?.countriesTableView.indexPath(for: cell) else { return }
        countriesViewModel.toggleFavorite(at: indexPath.row)
        countriesScreen?.countriesTableView.reloadRows(at: [indexPath], with: .none)
    }
}
