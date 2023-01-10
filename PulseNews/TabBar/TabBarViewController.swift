//
//  TabBarViewController.swift
//  Foodies
//
//  Created by Kaan Yeyrek on 12/31/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    private func setupVC() {
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favoritesVC = FavoritesViewController()
        
        homeVC.title = "News"
        searchVC.title = "Search"
        favoritesVC.title = "Favorites"
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        favoritesNav.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 2)
        
        setViewControllers([homeNav, searchNav, favoritesNav], animated: false)
        
        
    }
}
