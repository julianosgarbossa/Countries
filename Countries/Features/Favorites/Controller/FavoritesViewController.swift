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
                                                     region: Region(name: "América do Sul"),
                                                     continent: Continent(name: "América"),
                                                     area: "8.515.767",
                                                     borders: ["Argentina",
                                                               "Bolívia",
                                                               "Colômbia",
                                                               "Guiana",
                                                               "Guiana Francesa",
                                                               "Paraguai",
                                                               "Peru",
                                                               "Suriname",
                                                               "Uruguai",
                                                               "Venezuela"],
                                                     languages: ["Português"],
                                                     population: "213.421.037",
                                                     coin: "R$",
                                                     flag: "br",
                                                     isFavorited: true),
                                            Countrie(name: "Argentina",
                                                    capital: "Buenos Aires",
                                                     region: Region(name: "América do Sul"),
                                                     continent: Continent(name: "América"),
                                                     area: "2.780.400",
                                                     borders: ["Brasil",
                                                               "Chile",
                                                               "Paraguai",
                                                               "Bolívia",
                                                               "Uruguai"],
                                                     languages: ["Espanhol",
                                                                 "Guarani"],
                                                     population: "45.808.747",
                                                     coin: "$",
                                                     flag: "ar",
                                                     isFavorited: true),
                                            Countrie(name: "Canadá",
                                                     capital: "Ottawa",
                                                     region: Region(name: "América do Norte"),
                                                     continent: Continent(name: "América"),
                                                     area: "9.984.670",
                                                     borders: ["Estados Unidos"],
                                                     languages: ["Inglês",
                                                                 "Francês"],
                                                     population: "38.246.108",
                                                     coin: "$",
                                                     flag: "ca",
                                                     isFavorited: true),
                                            Countrie(name: "Espanha",
                                                     capital: "Madrid",
                                                     region: Region(name: "Europa Ocidental"),
                                                     continent: Continent(name: "Europa"),
                                                     area: "505.990",
                                                     borders: ["Portugal",
                                                               "França",
                                                               "Andorra",
                                                               "Marrocos"],
                                                     languages: ["Espanhol"],
                                                     population: "47.615.034",
                                                     coin: "€",
                                                     flag: "es",
                                                     isFavorited: true),
                                            Countrie(name: "Itália",
                                                     capital: "Roma",
                                                     region: Region(name: "Europa Meridional"),
                                                     continent: Continent(name: "Europa"),
                                                     area: "301.340",
                                                     borders: ["França",
                                                               "Suíça",
                                                               "Áustria",
                                                               "Eslovênia",
                                                               "San Marino",
                                                               "Vaticano"],
                                                     languages: ["Italiano"],
                                                     population: "58.870.762",
                                                     coin: "€",
                                                     flag: "it",
                                                     isFavorited: true),
                                            Countrie(name: "Japão",
                                                     capital: "Tokyo",
                                                     region: Region(name: "Leste Asiático"),
                                                     continent: Continent(name: "Ásia"),
                                                     area: "377.975",
                                                     borders: ["Nenhuma"],
                                                     languages: ["Japonês"],
                                                     population: "125.836.021",
                                                     coin: "¥",
                                                     flag: "jp",
                                                     isFavorited: true)
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
        let countrieDetailViewController = CountrieDetailViewController(countrie: countrieFavoriteList[indexPath.item])
        navigationController?.pushViewController(countrieDetailViewController, animated: true)
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
