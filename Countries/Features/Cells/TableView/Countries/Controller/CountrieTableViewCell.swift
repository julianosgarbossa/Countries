//
//  CountrieTableViewCell.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 18/03/26.
//

import UIKit

protocol CountrieTableViewCellDelegate: AnyObject {
    func countryCellDidTapFavorite(cell: CountrieTableViewCell)
}

class CountrieTableViewCell: UITableViewCell {

    static let identifier: String = String(describing: CountrieTableViewCell.self)
    static let heightForRowAt: CGFloat = 106
    
    private weak var delegate: CountrieTableViewCellDelegate?
    
    func delegate(delegate: CountrieTableViewCellDelegate) {
        self.delegate = delegate
    }
    
    private lazy var countrieTableViewCellScreen: CountrieTableViewCellScreen = {
        let view = CountrieTableViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addVisualElements()
        configProtocols()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configProtocols() {
        countrieTableViewCellScreen.delegate(delegate: self)
    }
    
    private func addVisualElements() {
        contentView.addSubview(countrieTableViewCellScreen)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            countrieTableViewCellScreen.topAnchor.constraint(equalTo: contentView.topAnchor),
            countrieTableViewCellScreen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            countrieTableViewCellScreen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            countrieTableViewCellScreen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupCell(countrie: Country) {
        countrieTableViewCellScreen.countrieFlagImageView.image = UIImage(named: countrie.flag)
        countrieTableViewCellScreen.countrieNameLabel.text = countrie.name
        countrieTableViewCellScreen.countrieCapitalLabel.text = countrie.capital
        countrieTableViewCellScreen.countrieRegionLabel.text = countrie.region.name
        countrieTableViewCellScreen.configButton(isFavorited: countrie.isFavorited)
    }
}

extension CountrieTableViewCell: CountrieTableViewCellScreenDelegate {
    func didTapFavotireButton() {
        delegate?.countryCellDidTapFavorite(cell: self)
    }
}
