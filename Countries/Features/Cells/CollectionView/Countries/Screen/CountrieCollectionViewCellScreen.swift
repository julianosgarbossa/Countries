//
//  CountrieCollectionViewCellScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 19/03/26.
//

import UIKit

class CountrieCollectionViewCellScreen: UIView {

    private lazy var cardFavoriteCountrieView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 47
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        return view
    }()
    
    lazy var countrieFlagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1).cgColor
        return imageView
    }()
    
    lazy var countrieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
        
        addSubview(cardFavoriteCountrieView)
        cardFavoriteCountrieView.addSubview(countrieFlagImageView)
        cardFavoriteCountrieView.addSubview(countrieNameLabel)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            cardFavoriteCountrieView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            cardFavoriteCountrieView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardFavoriteCountrieView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardFavoriteCountrieView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            countrieFlagImageView.topAnchor.constraint(equalTo: cardFavoriteCountrieView.topAnchor, constant: 14),
            countrieFlagImageView.leadingAnchor.constraint(equalTo: cardFavoriteCountrieView.leadingAnchor, constant: 14),
            countrieFlagImageView.trailingAnchor.constraint(equalTo: cardFavoriteCountrieView.trailingAnchor, constant: -14),
            countrieFlagImageView.heightAnchor.constraint(equalToConstant: 100),
            
            countrieNameLabel.topAnchor.constraint(equalTo: countrieFlagImageView.bottomAnchor, constant: 14),
            countrieNameLabel.leadingAnchor.constraint(equalTo: cardFavoriteCountrieView.leadingAnchor, constant: 14),
            countrieNameLabel.trailingAnchor.constraint(equalTo: cardFavoriteCountrieView.trailingAnchor, constant: -14),
        ])
    }
}
