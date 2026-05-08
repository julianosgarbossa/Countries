//
//  FavoritesScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 19/03/26.
//

import UIKit

class FavoritesScreen: UIView {

    private lazy var cardFavoritesCountriesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 48
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var favoritesCountriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: CountryCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        
        addSubview(cardFavoritesCountriesView)
        cardFavoritesCountriesView.addSubview(favoritesCountriesCollectionView)
        cardFavoritesCountriesView.addSubview(emptyStateLabel)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            cardFavoritesCountriesView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            cardFavoritesCountriesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardFavoritesCountriesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardFavoritesCountriesView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            favoritesCountriesCollectionView.topAnchor.constraint(equalTo: cardFavoritesCountriesView.topAnchor),
            favoritesCountriesCollectionView.leadingAnchor.constraint(equalTo: cardFavoritesCountriesView.leadingAnchor, constant: 12),
            favoritesCountriesCollectionView.trailingAnchor.constraint(equalTo: cardFavoritesCountriesView.trailingAnchor, constant: -12),
            favoritesCountriesCollectionView.bottomAnchor.constraint(equalTo: cardFavoritesCountriesView.bottomAnchor),
            
            emptyStateLabel.centerYAnchor.constraint(equalTo: cardFavoritesCountriesView.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: cardFavoritesCountriesView.leadingAnchor, constant: 24),
            emptyStateLabel.trailingAnchor.constraint(equalTo: cardFavoritesCountriesView.trailingAnchor, constant: -24),
        ])
    }
    
    func configCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        favoritesCountriesCollectionView.delegate = delegate
        favoritesCountriesCollectionView.dataSource = dataSource
    }
    
    func reloadCollectionView() {
        favoritesCountriesCollectionView.reloadData()
    }
    
    func showEmptyState(message: String) {
        emptyStateLabel.text = message
        emptyStateLabel.isHidden = false
        favoritesCountriesCollectionView.isHidden = true
    }
    
    func hideEmptyState() {
        emptyStateLabel.isHidden = true
        favoritesCountriesCollectionView.isHidden = false
    }
}
