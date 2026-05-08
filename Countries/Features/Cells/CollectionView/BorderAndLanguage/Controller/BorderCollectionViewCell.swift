//
//  BorderCollectionViewCell.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 23/03/26.
//

import UIKit

class BorderCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: BorderCollectionViewCell.self)
    static let countryBorderHeight: CGFloat = 56
    static let languageHeight: CGFloat = 48
    static let countryFlagWidth: CGFloat = 75
    static let languageIconSize: CGFloat = 32
    static let labelFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    private static let countryChipHorizontalSpacing: CGFloat = 14
    private static let countryChipTrailingPadding: CGFloat = 20
    private static let languageChipLeadingPadding: CGFloat = 18
    private static let languageChipHorizontalSpacing: CGFloat = 14
    private static let languageChipTrailingPadding: CGFloat = 26

    private lazy var borderCollectionViewCellScreen: BorderCollectionViewCellScreen = {
        let view = BorderCollectionViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.2
        view.layer.borderColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1).cgColor
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
        contentView.addSubview(borderCollectionViewCellScreen)

        NSLayoutConstraint.activate([
            borderCollectionViewCellScreen.topAnchor.constraint(equalTo: contentView.topAnchor),
            borderCollectionViewCellScreen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            borderCollectionViewCellScreen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            borderCollectionViewCellScreen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupCell(border: String) {
        borderCollectionViewCellScreen.layer.cornerRadius = Self.countryBorderHeight / 2
        borderCollectionViewCellScreen.configure(title: border, variant: .countryBorder)
    }

    func setupCell(language: String) {
        borderCollectionViewCellScreen.layer.cornerRadius = Self.languageHeight / 2
        borderCollectionViewCellScreen.configure(title: language, variant: .language)
    }

    static func calculateSize(title: String, variant: BorderCellContentVariant) -> CGSize {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: countryBorderHeight)
        let boundingBox = (title as NSString).boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: labelFont],
            context: nil
        )
        let textWidth = ceil(boundingBox.width)

        switch variant {
        case .countryBorder:
            let width = countryFlagWidth + countryChipHorizontalSpacing + textWidth + countryChipTrailingPadding
            return CGSize(width: width, height: countryBorderHeight)
        case .language:
            let width = languageChipLeadingPadding + languageIconSize + languageChipHorizontalSpacing + textWidth + languageChipTrailingPadding
            return CGSize(width: width, height: languageHeight)
        }
    }
}
