//
//  CountrieDetailScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 21/03/26.
//

import UIKit

protocol CountrieDetailScreenDelegate: AnyObject {
    func didTapDetailBackButton()
    func didTapFavoriteButton()
}

class CountrieDetailScreen: UIView {
    
    private weak var delegate: CountrieDetailScreenDelegate?
    
    func delegate(delegate: CountrieDetailScreenDelegate) {
        self.delegate = delegate
    }
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.contentInsetAdjustmentBehavior = .never
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var countrieFlagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 0.85
        blurView.layer.cornerRadius = 35
        blurView.clipsToBounds = true
        return blurView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        button.backgroundColor = .white
        button.layer.borderWidth = 0.1
        button.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapDetailBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        button.backgroundColor = .white
        button.layer.borderWidth = 0.1
        button.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        button.layer.cornerRadius = 19
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapDetailFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var cardDetailtCountrieView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 48
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        view.layer.borderWidth = 0.1
        view.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var countrieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        return label
    }()
    
    private lazy var regionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Região:"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var regionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var mapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "map")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var bordersContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 238/255, green: 239/255, blue: 243/255, alpha: 1.0)
        return view
    }()
    
    private lazy var bordersTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fronteiras"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var bordersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private lazy var capitalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .thin)
        imageView.image = UIImage(systemName: "building.columns", withConfiguration: config)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var capitalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Capital:"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.text = "Brasília"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var populationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        imageView.image = UIImage(systemName: "person.3", withConfiguration: config)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var populationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "População:"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var populationLabel: UILabel = {
        let label = UILabel()
        label.text = "213.421.037"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .thin)
        imageView.image = UIImage(systemName: "dollarsign.circle", withConfiguration: config)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var coinTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Moeda:"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var coinLabel: UILabel = {
        let label = UILabel()
        label.text = "R$"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var languagesContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 238/255, green: 239/255, blue: 243/255, alpha: 1.0)
        return view
    }()
    
    private lazy var languagesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Idiomas"
        label.textColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var languagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private lazy var contentScrollBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
        
    @objc
    private func didTapDetailBackButton(_ sender: UIButton) {
        delegate?.didTapDetailBackButton()
    }
    
    @objc
    private func didTapDetailFavoriteButton(_ sender: UIButton) {
        delegate?.didTapFavoriteButton()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addVisualElements() {
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(countrieFlagImageView)
        countrieFlagImageView.addSubview(blurView)
        blurView.contentView.addSubview(backButton)
        blurView.contentView.addSubview(favoriteButton)
        contentView.addSubview(cardDetailtCountrieView)
        cardDetailtCountrieView.addSubview(countrieNameLabel)
        cardDetailtCountrieView.addSubview(regionTitleLabel)
        cardDetailtCountrieView.addSubview(regionNameLabel)
        cardDetailtCountrieView.addSubview(mapImageView)
        cardDetailtCountrieView.addSubview(areaLabel)
        cardDetailtCountrieView.addSubview(contentScrollBottomView)
        cardDetailtCountrieView.addSubview(bordersContentView)
        bordersContentView.addSubview(bordersTitleLabel)
        bordersContentView.addSubview(bordersCollectionView)
        cardDetailtCountrieView.addSubview(capitalImageView)
        cardDetailtCountrieView.addSubview(capitalTitleLabel)
        cardDetailtCountrieView.addSubview(capitalLabel)
        cardDetailtCountrieView.addSubview(populationImageView)
        cardDetailtCountrieView.addSubview(populationTitleLabel)
        cardDetailtCountrieView.addSubview(populationLabel)
        cardDetailtCountrieView.addSubview(coinImageView)
        cardDetailtCountrieView.addSubview(coinTitleLabel)
        cardDetailtCountrieView.addSubview(coinLabel)
        cardDetailtCountrieView.addSubview(languagesContentView)
        languagesContentView.addSubview(languagesTitleLabel)
        languagesContentView.addSubview(languagesCollectionView)
        
        configConstraints()
        setupLayoutPriorities()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            countrieFlagImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            countrieFlagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            countrieFlagImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            countrieFlagImageView.heightAnchor.constraint(equalToConstant: 200),
            
            blurView.topAnchor.constraint(equalTo: countrieFlagImageView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: countrieFlagImageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: countrieFlagImageView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: countrieFlagImageView.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 12),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 38),
            backButton.widthAnchor.constraint(equalToConstant: 38),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 12),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteButton.heightAnchor.constraint(equalTo: backButton.heightAnchor),
            favoriteButton.widthAnchor.constraint(equalTo: backButton.widthAnchor),
            
            cardDetailtCountrieView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 12),
            cardDetailtCountrieView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardDetailtCountrieView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardDetailtCountrieView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardDetailtCountrieView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor, constant: -60),
            
            countrieNameLabel.topAnchor.constraint(equalTo: cardDetailtCountrieView.topAnchor, constant: 24),
            countrieNameLabel.leadingAnchor.constraint(equalTo: cardDetailtCountrieView.leadingAnchor, constant: 16),
            countrieNameLabel.trailingAnchor.constraint(equalTo: cardDetailtCountrieView.trailingAnchor, constant: -16),
            
            regionTitleLabel.topAnchor.constraint(equalTo: countrieNameLabel.bottomAnchor, constant: 16),
            regionTitleLabel.leadingAnchor.constraint(equalTo: countrieNameLabel.leadingAnchor),
            
            regionNameLabel.centerYAnchor.constraint(equalTo: regionTitleLabel.centerYAnchor),
            regionNameLabel.leadingAnchor.constraint(equalTo: regionTitleLabel.trailingAnchor, constant: 4),
            regionNameLabel.trailingAnchor.constraint(equalTo: countrieNameLabel.trailingAnchor),
            
            mapImageView.topAnchor.constraint(equalTo: regionNameLabel.bottomAnchor, constant: 12),
            mapImageView.leadingAnchor.constraint(equalTo: countrieNameLabel.leadingAnchor),
            mapImageView.trailingAnchor.constraint(equalTo: countrieNameLabel.trailingAnchor),
            mapImageView.heightAnchor.constraint(equalToConstant: 160),
            
            areaLabel.topAnchor.constraint(equalTo: mapImageView.bottomAnchor, constant: 12),
            areaLabel.leadingAnchor.constraint(equalTo: countrieNameLabel.leadingAnchor),
            areaLabel.trailingAnchor.constraint(equalTo: countrieNameLabel.trailingAnchor),
            
            bordersContentView.topAnchor.constraint(equalTo: areaLabel.bottomAnchor, constant: 12),
            bordersContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bordersContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bordersContentView.heightAnchor.constraint(equalToConstant: 104),
            
            bordersTitleLabel.topAnchor.constraint(equalTo: bordersContentView.topAnchor, constant: 12),
            bordersTitleLabel.leadingAnchor.constraint(equalTo: countrieNameLabel.leadingAnchor),
            bordersTitleLabel.trailingAnchor.constraint(equalTo: countrieNameLabel.trailingAnchor),
            
            bordersCollectionView.topAnchor.constraint(equalTo: bordersTitleLabel.bottomAnchor, constant: 12),
            bordersCollectionView.leadingAnchor.constraint(equalTo: countrieNameLabel.leadingAnchor),
            bordersCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bordersCollectionView.heightAnchor.constraint(equalToConstant: 48),
            
            capitalImageView.topAnchor.constraint(equalTo: bordersContentView.bottomAnchor, constant: 12),
            capitalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            capitalImageView.heightAnchor.constraint(equalToConstant: 45),
            capitalImageView.widthAnchor.constraint(equalToConstant: 45),
            
            capitalTitleLabel.centerYAnchor.constraint(equalTo: capitalImageView.centerYAnchor),
            capitalTitleLabel.leadingAnchor.constraint(equalTo: capitalImageView.trailingAnchor, constant: 4),
            
            capitalLabel.centerYAnchor.constraint(equalTo: capitalTitleLabel.centerYAnchor),
            capitalLabel.leadingAnchor.constraint(equalTo: capitalTitleLabel.trailingAnchor, constant: 4),
            capitalLabel.trailingAnchor.constraint(equalTo: countrieNameLabel.trailingAnchor),
            
            populationImageView.topAnchor.constraint(equalTo: capitalImageView.bottomAnchor, constant: 12),
            populationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            populationImageView.heightAnchor.constraint(equalTo: capitalImageView.heightAnchor),
            populationImageView.widthAnchor.constraint(equalTo: capitalImageView.widthAnchor),
            
            populationTitleLabel.centerYAnchor.constraint(equalTo: populationImageView.centerYAnchor),
            populationTitleLabel.leadingAnchor.constraint(equalTo: populationImageView.trailingAnchor, constant: 4),
            
            populationLabel.centerYAnchor.constraint(equalTo: populationTitleLabel.centerYAnchor),
            populationLabel.leadingAnchor.constraint(equalTo: populationTitleLabel.trailingAnchor, constant: 4),
            populationLabel.trailingAnchor.constraint(equalTo: countrieNameLabel.trailingAnchor),
            
            coinImageView.topAnchor.constraint(equalTo: populationImageView.bottomAnchor, constant: 12),
            coinImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coinImageView.heightAnchor.constraint(equalTo: capitalImageView.heightAnchor),
            coinImageView.widthAnchor.constraint(equalTo: capitalImageView.widthAnchor),
            
            coinTitleLabel.centerYAnchor.constraint(equalTo: coinImageView.centerYAnchor),
            coinTitleLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 4),
            
            coinLabel.centerYAnchor.constraint(equalTo: coinTitleLabel.centerYAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: coinTitleLabel.trailingAnchor, constant: 4),
            coinLabel.trailingAnchor.constraint(equalTo: countrieNameLabel.trailingAnchor),
            
            languagesContentView.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: 12),
            languagesContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            languagesContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            languagesContentView.heightAnchor.constraint(equalTo: bordersContentView.heightAnchor),
            
            languagesTitleLabel.topAnchor.constraint(equalTo: languagesContentView.topAnchor, constant: 12),
            languagesTitleLabel.leadingAnchor.constraint(equalTo: countrieNameLabel.leadingAnchor),
            languagesTitleLabel.trailingAnchor.constraint(equalTo: countrieNameLabel.trailingAnchor),
            
            languagesCollectionView.topAnchor.constraint(equalTo: languagesTitleLabel.bottomAnchor, constant: 12),
            languagesCollectionView.leadingAnchor.constraint(equalTo: countrieNameLabel.leadingAnchor),
            languagesCollectionView.trailingAnchor.constraint(equalTo: bordersCollectionView.trailingAnchor),
            languagesCollectionView.heightAnchor.constraint(equalTo: bordersCollectionView.heightAnchor),
            
            contentScrollBottomView.topAnchor.constraint(equalTo: languagesContentView.bottomAnchor),
            contentScrollBottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentScrollBottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentScrollBottomView.bottomAnchor.constraint(equalTo: cardDetailtCountrieView.bottomAnchor, constant: -24),
        ])
    }
    
    private func setupLayoutPriorities() {
        regionTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        regionTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        regionNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        regionNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        capitalTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        capitalTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        capitalLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        capitalLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        populationTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        populationTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        populationLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        populationLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        coinTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        coinTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        coinLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        coinLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
