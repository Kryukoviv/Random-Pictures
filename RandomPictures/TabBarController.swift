//
//  NavigationController.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 28/08/2020.
//  Copyright © 2020 User. All rights reserved.
//
import UIKit
import Foundation

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomPicturesVC = RandomPicturesListAssembly().create()
        let favoritesListVC = FavoritesListAssembly().create()
        randomPicturesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let tabBarList = [randomPicturesVC, favoritesListVC]
        viewControllers = tabBarList
    }
}

