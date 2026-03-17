//
//  ProfileScreen.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

protocol ProfileScreenDelegate: AnyObject {
    func didTapLogoutButton()
}

class ProfileScreen: UIView {
    
    private weak var delegate: ProfileScreenDelegate?
    
    func delegate(delegate: ProfileScreenDelegate) {
        self.delegate = delegate
    }
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Fazer Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1
        button.backgroundColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func didTapLogoutButton(_sender: UIButton) {
        self.delegate?.didTapLogoutButton()
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
        
        addSubview(logoutButton)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            logoutButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
