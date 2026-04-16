//
//  CountryCollectionViewCell.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 19/03/26.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: CountryCollectionViewCell.self)
    static let horizontalPadding: CGFloat = 12
    static let interItemSpacing: CGFloat = 12
    static let itemHeight: CGFloat = 171
    
    private lazy var countryCollectionViewCellScreen: CountryCollectionViewCellScreen = {
        let view = CountryCollectionViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        contentView.addSubview(countryCollectionViewCellScreen)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            countryCollectionViewCellScreen.topAnchor.constraint(equalTo: contentView.topAnchor),
            countryCollectionViewCellScreen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            countryCollectionViewCellScreen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            countryCollectionViewCellScreen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupCell(country: Country) {
        countryCollectionViewCellScreen.configure(country: country)
    }
}
