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
        configNavigationControler()
    }
    
    private func configNavigationControler() {
        navigationItem.title = "Países Favoritos"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func configProtocols() {
        favoritesScreen?.configCollectionView(delegate: self, dataSource: self)
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let countrieDetailViewController = CountrieDetailViewController(countrie: favoritesViewModel.country(at: indexPath.item))
        navigationController?.pushViewController(countrieDetailViewController, animated: true)
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesViewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.identifier, for: indexPath) as? CountryCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(country: favoritesViewModel.country(at: indexPath.item))
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (CountryCollectionViewCell.horizontalPadding * 2) + CountryCollectionViewCell.interItemSpacing
        return CGSize(width: (view.bounds.width - totalSpacing) / 2, height: CountryCollectionViewCell.itemHeight)
    }
}
