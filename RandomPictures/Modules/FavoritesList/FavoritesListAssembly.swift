//
//  FavoritesListAssembly.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 26/08/2020.
//  Copyright © 2020 User. All rights reserved.
//
import UIKit
import Foundation

class FavoritesListAssembly {
    func create() -> UINavigationController {
        let randomPicturesVC = RandomPicturesListViewController()
        let navigationVC = UINavigationController(rootViewController: randomPicturesVC)
        let router = FavoritesListRouter(navigationController: navigationVC)
        let presenter = FavoritesListPresenter(
            view: randomPicturesVC,
            router: router,
            pictureStorage: PictureStorage()
        )
        randomPicturesVC.presenter = presenter

        return navigationVC
    }
}
