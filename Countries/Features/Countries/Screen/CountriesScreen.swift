//
//  CountriesScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class CountriesScreen: UIView {
    
    private lazy var countrieSearchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = "Buscar país por nome"
        search.searchBarStyle = .minimal
        search.layer.cornerRadius = 24
        search.backgroundColor = .white
        search.autocapitalizationType = .none
        search.autocorrectionType = .no
        return search
    }()
    
    private lazy var regionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ContinentCollectionViewCell.self, forCellWithReuseIdentifier: ContinentCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var cardTableView: UIView = {
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
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var countriesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountrieTableViewCell.self, forCellReuseIdentifier: CountrieTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
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
        
        addSubview(countrieSearchBar)
        addSubview(regionsCollectionView)
        addSubview(cardTableView)
        cardTableView.addSubview(countriesTableView)
        cardTableView.addSubview(emptyStateLabel)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            countrieSearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            countrieSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            countrieSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            countrieSearchBar.heightAnchor.constraint(equalToConstant: 48),
            
            regionsCollectionView.topAnchor.constraint(equalTo: countrieSearchBar.bottomAnchor, constant: 16),
            regionsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            regionsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            regionsCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            cardTableView.topAnchor.constraint(equalTo: regionsCollectionView.bottomAnchor, constant: 16),
            cardTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            countriesTableView.topAnchor.constraint(equalTo: cardTableView.topAnchor),
            countriesTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            countriesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            countriesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyStateLabel.centerYAnchor.constraint(equalTo: cardTableView.centerYAnchor),
            emptyStateLabel.leadingAnchor.constraint(equalTo: countriesTableView.leadingAnchor),
            emptyStateLabel.trailingAnchor.constraint(equalTo: countriesTableView.trailingAnchor),
        ])
    }
    
    func configSearchBar(delegate: UISearchBarDelegate) {
        countrieSearchBar.delegate = delegate
    }
    
    func configCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        regionsCollectionView.delegate = delegate
        regionsCollectionView.dataSource = dataSource
    }
    
    func configTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        countriesTableView.delegate = delegate
        countriesTableView.dataSource = dataSource
    }
    
    func reloadTableView() {
        countriesTableView.reloadData()
    }
    
    func reloadTableViewRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        countriesTableView.reloadRows(at: indexPaths, with: animation)
    }
    
    func indexPathForTableViewCell(_ cell: UITableViewCell) -> IndexPath? {
        countriesTableView.indexPath(for: cell)
    }
    
    func showEmptyState(message: String) {
        emptyStateLabel.text = message
        emptyStateLabel.isHidden = false
        countriesTableView.isHidden = true
    }

    func hideEmptyState() {
        emptyStateLabel.isHidden = true
        countriesTableView.isHidden = false
    }
}
