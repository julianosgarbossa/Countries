//
//  CountrieTableViewCellScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 18/03/26.
//

import UIKit

protocol CountrieTableViewCellScreenDelegate: AnyObject {
    func didTapFavotireButton()
}

class CountrieTableViewCellScreen: UIView {
    
    private weak var delegate: CountrieTableViewCellScreenDelegate?
    
    func delegate(delegate: CountrieTableViewCellScreenDelegate) {
        self.delegate = delegate
    }
  
    private lazy var cardCountrieView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 47
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        return view
    }()
    
    private lazy var countrieFlagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.highlightedImage = nil
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1).cgColor
        return imageView
    }()
    
    private lazy var countrieNameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "País:"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var countrieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var countrieCapitalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Capital:"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var countrieCapitalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var countrieRegionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Região:"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var countrieRegionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        return imageView
    }()
    
    @objc
    private func didTapFavoriteButton(_ sender: UIButton) {
        delegate?.didTapFavotireButton()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        backgroundColor = .white
        
        addSubview(cardCountrieView)
        cardCountrieView.addSubview(countrieFlagImageView)
        cardCountrieView.addSubview(countrieCapitalTitleLabel)
        cardCountrieView.addSubview(countrieNameTitleLabel)
        cardCountrieView.addSubview(countrieRegionTitleLabel)
        cardCountrieView.addSubview(countrieCapitalLabel)
        cardCountrieView.addSubview(countrieNameLabel)
        cardCountrieView.addSubview(countrieRegionLabel)
        cardCountrieView.addSubview(favoriteButton)
        cardCountrieView.addSubview(arrowImageView)
        
        configConstraints()
        setupLayoutPriorities()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            cardCountrieView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            cardCountrieView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardCountrieView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardCountrieView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            countrieFlagImageView.topAnchor.constraint(equalTo: cardCountrieView.topAnchor, constant: 12),
            countrieFlagImageView.leadingAnchor.constraint(equalTo: cardCountrieView.leadingAnchor, constant: 12),
            countrieFlagImageView.widthAnchor.constraint(equalToConstant: 100),
            countrieFlagImageView.heightAnchor.constraint(equalToConstant: 70),
            
            countrieCapitalTitleLabel.centerYAnchor.constraint(equalTo: countrieFlagImageView.centerYAnchor),
            countrieCapitalTitleLabel.leadingAnchor.constraint(equalTo: countrieFlagImageView.trailingAnchor, constant: 12),
            
            countrieNameTitleLabel.bottomAnchor.constraint(equalTo: countrieCapitalTitleLabel.topAnchor, constant: -8),
            countrieNameTitleLabel.leadingAnchor.constraint(equalTo: countrieCapitalTitleLabel.leadingAnchor),
            
            countrieRegionTitleLabel.topAnchor.constraint(equalTo: countrieCapitalTitleLabel.bottomAnchor, constant: 8),
            countrieRegionTitleLabel.leadingAnchor.constraint(equalTo: countrieCapitalTitleLabel.leadingAnchor),
            
            countrieCapitalLabel.centerYAnchor.constraint(equalTo: countrieCapitalTitleLabel.centerYAnchor),
            countrieCapitalLabel.leadingAnchor.constraint(equalTo: countrieCapitalTitleLabel.trailingAnchor, constant: 4),
            countrieCapitalLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -4),
            
            countrieNameLabel.centerYAnchor.constraint(equalTo: countrieNameTitleLabel.centerYAnchor),
            countrieNameLabel.leadingAnchor.constraint(equalTo: countrieNameTitleLabel.trailingAnchor, constant: 4),
            countrieNameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -4),
            
            countrieRegionLabel.centerYAnchor.constraint(equalTo: countrieRegionTitleLabel.centerYAnchor),
            countrieRegionLabel.leadingAnchor.constraint(equalTo: countrieRegionTitleLabel.trailingAnchor, constant: 4),
            countrieRegionLabel.trailingAnchor.constraint(equalTo: cardCountrieView.trailingAnchor, constant: -18),
            
            favoriteButton.centerYAnchor.constraint(equalTo: countrieNameLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: cardCountrieView.trailingAnchor, constant: -30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 22),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            
            arrowImageView.centerYAnchor.constraint(equalTo: countrieCapitalLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: cardCountrieView.trailingAnchor, constant: -12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 18),
            arrowImageView.widthAnchor.constraint(equalToConstant: 12),
        ])
    }
    
    private func setupLayoutPriorities() {
        countrieNameTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        countrieNameTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        countrieCapitalTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        countrieCapitalTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        countrieRegionTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        countrieRegionTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        countrieNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        countrieNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        countrieCapitalLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        countrieCapitalLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        countrieRegionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        countrieRegionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func configure(country: Country) {
        countrieFlagImageView.image = UIImage(named: country.flag)
        countrieNameLabel.text = country.name
        countrieCapitalLabel.text = country.capital
        countrieRegionLabel.text = country.region.name
        configureFavoriteButton(isFavorited: country.isFavorited)
    }
    
    private func configureFavoriteButton(isFavorited: Bool) {
        favoriteButton.setImage( isFavorited ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        favoriteButton.tintColor = isFavorited ? UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1) : UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
    }
}
