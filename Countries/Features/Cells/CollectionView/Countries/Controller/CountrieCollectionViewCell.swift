//
//  CountrieCollectionViewCell.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 19/03/26.
//

import UIKit

class CountrieCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: CountrieCollectionViewCell.self)
    
    private lazy var countrieCollectionViewCellScreen: CountrieCollectionViewCellScreen = {
        let view = CountrieCollectionViewCellScreen()
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
        contentView.addSubview(countrieCollectionViewCellScreen)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            countrieCollectionViewCellScreen.topAnchor.constraint(equalTo: contentView.topAnchor),
            countrieCollectionViewCellScreen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            countrieCollectionViewCellScreen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            countrieCollectionViewCellScreen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupCell(countrie: Countrie) {
        countrieCollectionViewCellScreen.countrieFlagImageView.image = UIImage(named: countrie.flag)
        countrieCollectionViewCellScreen.countrieNameLabel.text = countrie.name
    }
}
