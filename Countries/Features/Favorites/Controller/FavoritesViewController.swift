//
//  FavoritesViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 19/03/26.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private var favoritesScreen: FavoritesScreen?
    
    private var countrieFavoriteList: [Countrie] = [Countrie(name: "Brasil",
                                                     capital: "Brasília",
                                                     region: Region(name: "América"),
                                                     flag: "br",
                                                     isFavorited: true),
                                            Countrie(name: "Argentina",
                                                      capital: "Buenos Aires",
                                                      region: Region(name: "América"),
                                                      flag: "ar",
                                                      isFavorited: true),
                                            Countrie(name: "Canadá",
                                                      capital: "Ottawa",
                                                      region: Region(name: "América"),
                                                      flag: "ca",
                                                      isFavorited: true),
                                            Countrie(name: "Espanha",
                                                      capital: "Madrid",
                                                      region: Region(name: "Europa"),
                                                      flag: "es",
                                                      isFavorited: true),
                                            Countrie(name: "Itália",
                                                      capital: "Roma",
                                                      region: Region(name: "Europa"),
                                                      flag: "it",
                                                      isFavorited: true),
                                            Countrie(name: "Japão",
                                                      capital: "Tokyo",
                                                      region: Region(name: "Ásia"),
                                                      flag: "jp",
                                                      isFavorited: true),
    ]
    
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
        print("Navegar para tela de detalhes do país: \(countrieFavoriteList[indexPath.item].name)")
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countrieFavoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountrieCollectionViewCell.identifier, for: indexPath) as? CountrieCollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(countrie: countrieFavoriteList[indexPath.item])
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.width - 36) / 2, height: 171)
    }
}
