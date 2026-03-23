//
//  CountrieDetailViewController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 21/03/26.
//

import UIKit

class CountrieDetailViewController: UIViewController {
    
    private var countrie: Countrie
    private var countrieDetailScreen: CountrieDetailScreen?
    
    init(countrie: Countrie) {
        self.countrie = countrie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        countrieDetailScreen = CountrieDetailScreen()
        view = countrieDetailScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationControler()
        configProtocols()
        configDetailScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationControler()
    }
    
    private func configNavigationControler() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configProtocols() {
        countrieDetailScreen?.delegate(delegate: self)
    }
    
    func configDetailScreen() {
        countrieDetailScreen?.countrieFlagImageView.image = UIImage(named: countrie.flag)
        countrieDetailScreen?.favoriteButton.setImage(UIImage(systemName: countrie.isFavorited ? "star.fill" : "star"), for: .normal)
        countrieDetailScreen?.favoriteButton.tintColor = countrie.isFavorited ? UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1) : UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        countrieDetailScreen?.countrieNameLabel.text = countrie.name
        countrieDetailScreen?.regionNameLabel.text = countrie.region.name
        countrieDetailScreen?.areaLabel.text = "Área: \(countrie.area) km²"
        countrieDetailScreen?.capitalLabel.text = countrie.capital
        countrieDetailScreen?.populationLabel.text = "\(countrie.population) pessoas"
        countrieDetailScreen?.coinLabel.text = countrie.coin
    }
}

extension CountrieDetailViewController: CountrieDetailScreenDelegate {
    func didTapDetailBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapFavoriteButton() {
        countrie.isFavorited.toggle()
        configDetailScreen()
    }
}
