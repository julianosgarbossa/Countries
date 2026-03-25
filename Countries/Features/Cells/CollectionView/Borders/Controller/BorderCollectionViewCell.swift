//
//  BorderCollectionViewCell.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 23/03/26.
//

import UIKit

class BorderCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: BorderCollectionViewCell.self)
    static let heightCell: CGFloat = 48
    static let labelFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    private lazy var borderCollectionViewCellScreen: BorderCollectionViewCellScreen = {
        let view = BorderCollectionViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1
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
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            borderCollectionViewCellScreen.topAnchor.constraint(equalTo: contentView.topAnchor),
            borderCollectionViewCellScreen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            borderCollectionViewCellScreen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            borderCollectionViewCellScreen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupCell(border: String) {
        borderCollectionViewCellScreen.borderNameLabel.text = border
    }
    
    static func calculateSize(title: String) -> CGSize {
      let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: heightCell)
      let boundingBox = (title as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: labelFont], context: nil)
      let widthLayer: CGFloat = 32
      return CGSize(width: boundingBox.width + widthLayer, height: heightCell)
    }
}
