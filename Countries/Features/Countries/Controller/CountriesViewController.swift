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
        countriesViewModel.fetchCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationControler()
        countriesViewModel.refreshFavoritesState()
        updateCountriesListUI()
    }
    
    private func configNavigationControler() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configProtocols() {
        countriesScreen?.configSearchBar(delegate: self)
        countriesScreen?.configCollectionView(delegate: self, dataSource: self)
        countriesScreen?.configTableView(delegate: self, dataSource: self)
        countriesViewModel.delegate = self
    }
    
    private func updateCountriesListUI() {
        countriesScreen?.reloadTableView()
        
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
        guard countriesScreen?.isShimmerActive == false else { return }
        let countrieDetailViewController = CountryDetailViewController(countryId: countriesViewModel.country(at: indexPath.row).cca2)
        navigationController?.pushViewController(countrieDetailViewController, animated: true)
    }
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let shimmerCount = countriesScreen?.shimmerCellCount, shimmerCount > 0 {
            return shimmerCount
        }
        return countriesViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if countriesScreen?.isShimmerActive == true {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ShimmerTableViewCell.identifier, for: indexPath) as? ShimmerTableViewCell else {
                return UITableViewCell()
            }
            cell.startShimmering()
            return cell
        }

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
        guard let indexPath = countriesScreen?.indexPathForTableViewCell(cell) else { return }
        countriesViewModel.toggleFavorite(at: indexPath.row)
        countriesScreen?.reloadTableViewRows(at: [indexPath], with: .none)
    }
}

extension CountriesViewController: CountriesViewModelProtocol {
    func countriesViewModelUpdateUI() {
        countriesScreen?.reloadCollectionView()
        updateCountriesListUI()
    }

    func countriesViewModelDidChangeState(_ state: ViewState) {
        switch state {
        case .loading:
            countriesScreen?.showShimmer()
        case .loaded, .error, .empty:
            countriesScreen?.hideShimmer()
        case .idle:
            break
        }
    }
}
