//
//  RegionCollectionViewCell.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 18/03/26.
//

import UIKit

class RegionCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: RegionCollectionViewCell.self)
    static let heightCell: CGFloat = 40
    static let labelFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    
    private lazy var regionCollectionViewCellSreen: RegionCollectionViewCellScreen = {
        let view = RegionCollectionViewCellScreen()
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
        contentView.addSubview(regionCollectionViewCellSreen)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            regionCollectionViewCellSreen.topAnchor.constraint(equalTo: contentView.topAnchor),
            regionCollectionViewCellSreen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            regionCollectionViewCellSreen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            regionCollectionViewCellSreen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupCell(region: Region) {
        regionCollectionViewCellSreen.regionNameLabel.text = region.name
        regionCollectionViewCellSreen.regionNameLabel.textColor = region.isSelected ? UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1) : UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
    }
    
    static func calculateSize(title: String) -> CGSize {
      let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: heightCell)
      let boundingBox = (title as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: labelFont], context: nil)
      let widthLayer: CGFloat = 32
      return CGSize(width: boundingBox.width + widthLayer, height: heightCell)
    }
}
