//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 21/03/26.
//

import UIKit

class CountryDetailViewController: UIViewController {
    
    private var countryDetailScreen: CountryDetailScreen?
    private let countryDetailViewModel: CountryDetailViewModel
    
    init(country: Country) {
        countryDetailViewModel = CountryDetailViewModel(country: country)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        countryDetailScreen = CountryDetailScreen()
        view = countryDetailScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationControler()
        configProtocols()
        configDetailScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationControler()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        countryDetailScreen?.setScrollBottomInset(view.safeAreaInsets.bottom)
    }
    
    private func configNavigationControler() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configProtocols() {
        countryDetailScreen?.delegate(delegate: self)
        countryDetailScreen?.configCollectionView(delegate: self, dataSource: self)
        countryDetailViewModel.delegate = self
    }
    
    func configDetailScreen() {
        countryDetailScreen?.updateUI(data: countryDetailViewModel.countryDetailData)
    }
}

extension CountryDetailViewController: CountrieDetailScreenDelegate {
    func didTapDetailBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapFavoriteButton() {
        countryDetailViewModel.didTapFavorite()
    }
}

extension CountryDetailViewController: UICollectionViewDelegate {
    
}

extension CountryDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let type = countryDetailScreen?.collectionViewType(for: collectionView) else { return 0 }
        
        switch type {
        case .languages:
            return countryDetailViewModel.languagesCount
        case .borders:
            return countryDetailViewModel.bordersCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let type = countryDetailScreen?.collectionViewType(for: collectionView) else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BorderCollectionViewCell.identifier, for: indexPath) as? BorderCollectionViewCell else { return UICollectionViewCell() }
        
        switch type {
        case .languages:
            cell.setupCell(language: countryDetailViewModel.language(at: indexPath.item))
        case .borders:
            cell.setupCell(border: countryDetailViewModel.border(at: indexPath.item))
        }
        
        return cell
    }
}

extension CountryDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let type = countryDetailScreen?.collectionViewType(for: collectionView) else { return .zero }
        
        switch type {
        case .languages:
            return BorderCollectionViewCell.calculateSize(title: countryDetailViewModel.language(at: indexPath.item), variant: .language)
        case .borders:
            return BorderCollectionViewCell.calculateSize(title: countryDetailViewModel.border(at: indexPath.item), variant: .countryBorder)
        }
    }
}

extension CountryDetailViewController: CountryDetailViewModelDelegate {
    func countryDetailDidUpdate() {
        configDetailScreen()
    }
}
