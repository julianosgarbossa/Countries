//
//  FavoritesViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 19/03/26.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private var favoritesScreen: FavoritesScreen?
    private let favoritesViewModel = FavoritesViewModel()
    
    override func loadView() {
        favoritesScreen = FavoritesScreen()
        view = favoritesScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configProtocols()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationControler()
        fetchFavorites()
    }
    
    private func configNavigationControler() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Países Favoritos"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func configProtocols() {
        favoritesScreen?.configCollectionView(delegate: self, dataSource: self)
    }
    
    private func fetchFavorites() {
        if favoritesViewModel.state != .loaded {
            favoritesScreen?.showShimmer()
        }

        favoritesViewModel.fetchFavorites { [weak self] in
            guard let self else { return }
            
            self.favoritesScreen?.hideShimmer()
            self.favoritesScreen?.reloadCollectionView()
            
            if self.favoritesViewModel.shouldShowEmptyState {
                self.favoritesScreen?.showEmptyState(message: self.favoritesViewModel.emptyStateMessage)
            } else {
                self.favoritesScreen?.hideEmptyState()
            }
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard favoritesScreen?.isShimmerActive == false else { return }
        guard let country = favoritesViewModel.countryIfAvailable(at: indexPath.item) else { return }
        
        let countrieDetailViewController = CountryDetailViewController(countryId: country.cca2)
        navigationController?.pushViewController(countrieDetailViewController, animated: true)
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let shimmerCount = favoritesScreen?.shimmerCellCount, shimmerCount > 0 {
            return shimmerCount
        }
        return favoritesViewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if favoritesScreen?.isShimmerActive == true {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShimmerCollectionViewCell.identifier, for: indexPath) as? ShimmerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.startShimmering()
            return cell
        }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.identifier, for: indexPath) as? CountryCollectionViewCell else { return UICollectionViewCell() }
        
        guard let country = favoritesViewModel.countryIfAvailable(at: indexPath.item) else {
            return cell
        }
        
        cell.setupCell(country: country)
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (CountryCollectionViewCell.horizontalPadding * 2) + CountryCollectionViewCell.interItemSpacing
        return CGSize(width: (view.bounds.width - totalSpacing) / 2, height: CountryCollectionViewCell.itemHeight)
    }
}
