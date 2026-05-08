//
//  BorderCollectionViewCellScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 23/03/26.
//

import UIKit

enum BorderCellContentVariant {
    case countryBorder
    case language
}

class BorderCollectionViewCellScreen: UIView {

    private var flagWidthConstraint: NSLayoutConstraint?
    private var flagHeightConstraint: NSLayoutConstraint?
    private var labelLeadingConstraint: NSLayoutConstraint?

    private lazy var flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 248/255, alpha: 1)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    }()

    private lazy var borderNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
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
        backgroundColor = .white
        
        addSubview(flagImageView)
        addSubview(borderNameLabel)

        let flagWidthConstraint = flagImageView.widthAnchor.constraint(equalToConstant: BorderCollectionViewCell.countryFlagWidth)
        let flagHeightConstraint = flagImageView.heightAnchor.constraint(equalToConstant: BorderCollectionViewCell.countryBorderHeight)
        let labelLeadingConstraint = borderNameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 14)
        self.flagWidthConstraint = flagWidthConstraint
        self.flagHeightConstraint = flagHeightConstraint
        self.labelLeadingConstraint = labelLeadingConstraint

        NSLayoutConstraint.activate([
            flagImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            flagWidthConstraint,
            flagHeightConstraint,

            labelLeadingConstraint,
            borderNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            borderNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    func prepareForReuse() {
        flagImageView.cancelImageLoad()
        flagImageView.image = nil
        borderNameLabel.text = nil
    }
    
    func configure(language: String) {
        borderNameLabel.text = language
        flagImageView.isHidden = false
        borderNameLabel.textAlignment = .left
        borderNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        flagWidthConstraint?.constant = BorderCollectionViewCell.languageIconSize + 18
        flagHeightConstraint?.constant = BorderCollectionViewCell.languageIconSize
        labelLeadingConstraint?.constant = 14
        flagImageView.layer.cornerRadius = 0
        applyLanguageIcon()
    }
    
    func configure(borderCountry: BorderCountry) {
        borderNameLabel.text = borderCountry.name
        flagImageView.isHidden = false
        borderNameLabel.textAlignment = .natural
        borderNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        flagWidthConstraint?.constant = BorderCollectionViewCell.countryFlagWidth
        flagHeightConstraint?.constant = BorderCollectionViewCell.countryBorderHeight
        labelLeadingConstraint?.constant = 14
        flagImageView.layer.cornerRadius = BorderCollectionViewCell.countryBorderHeight / 2
        flagImageView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        applyFlagImage(urlString: borderCountry.flagURL)
    }

    private func applyFlagImage(urlString: String) {
        guard !urlString.isEmpty else {
            applyFlagPlaceholder()
            return
        }
        
        flagImageView.tintColor = nil
        flagImageView.contentMode = .scaleAspectFill
        flagImageView.backgroundColor = .clear
        flagImageView.downloadImage(
            urlString: urlString,
            placeholderImage: UIImage(systemName: "globe.americas.fill"),
            errorImage: UIImage(systemName: "globe.americas.fill")
        )
    }
    
    private func applyFlagPlaceholder() {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        flagImageView.image = UIImage(systemName: "globe.americas.fill", withConfiguration: config)
        flagImageView.tintColor = UIColor(red: 160/255, green: 164/255, blue: 172/255, alpha: 1)
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 248/255, alpha: 1)
    }

    private func applyLanguageIcon() {
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        flagImageView.image = UIImage(systemName: "globe", withConfiguration: config)
        flagImageView.tintColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.backgroundColor = .clear
    }
}
