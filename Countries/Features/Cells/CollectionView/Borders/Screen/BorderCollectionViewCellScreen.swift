//
//  BorderCollectionViewCellScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 23/03/26.
//

import UIKit

class BorderCollectionViewCellScreen: UIView {

    lazy var borderNameLabel: UILabel = {
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
        backgroundColor = .white
        
        addSubview(borderNameLabel)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            borderNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            borderNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
