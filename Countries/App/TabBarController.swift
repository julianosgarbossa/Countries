//
//  TabBarController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    private func configViews() {
        let countries = createNavController(viewController: CountriesViewController(), title: "Países", imageName: "magnifyingglass")
        let favorite = createNavController(viewController: UIViewController(), title: "Favoritos", imageName: "star")
        let profile = createNavController(viewController: ProfileViewController(), title: "Perfil", imageName: "gear")
        
        viewControllers = [countries, favorite, profile]
        customizeTabBarAppearance()
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        return navController
    }
    
    private func customizeTabBarAppearance() {
        tabBar.tintColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.layer.borderColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1).cgColor
        tabBar.layer.borderWidth = 0.5
    }
}
