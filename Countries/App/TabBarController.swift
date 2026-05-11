//
//  TabBarController.swift
//  Countries
//
//  Created by Juliano Sgarbossa on 17/03/26.
//

import UIKit

class TabBarController: UITabBarController {
    private let accentColor = UIColor(red: 253/255, green: 155/255, blue: 1/255, alpha: 1)
    private let grayTextColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    private func configViews() {
        let countries = createNavController(viewController: CountriesViewController(), title: "Países", imageName: "magnifyingglass")
        let favorite = createNavController(viewController: FavoritesViewController(), title: "Favoritos", imageName: "star")
        let profile = createNavController(viewController: ProfileViewController(), title: "Perfil", imageName: "gear")
        
        viewControllers = [countries, favorite, profile]
        customizeTabBarAppearance()
    }
    
    private func createNavController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        customizeNavigationBarAppearance(navController.navigationBar)
        return navController
    }
    
    private func customizeTabBarAppearance() {
        tabBar.tintColor = accentColor
        tabBar.unselectedItemTintColor = grayTextColor
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.layer.borderColor = grayTextColor.cgColor
        tabBar.layer.borderWidth = 0.5
    }

    private func customizeNavigationBarAppearance(_ navigationBar: UINavigationBar) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = accentColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.shadowColor = .clear

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
    }
}
