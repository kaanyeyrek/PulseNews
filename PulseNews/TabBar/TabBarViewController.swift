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
        let categoriesVC = CategoriesViewController()
        
        homeVC.title = "News"
        searchVC.title = "Search"
        categoriesVC.title = "Categories"
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let categoriesNav = UINavigationController(rootViewController: categoriesVC)
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        categoriesNav.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "circle.grid.2x2"), tag: 2)
        
        setViewControllers([homeNav, searchNav, categoriesNav], animated: false)
        
        
    }
}
