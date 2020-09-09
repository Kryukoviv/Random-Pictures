//
//  RandomPicturesListAssembly.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 26/08/2020.
//  Copyright © 2020 User. All rights reserved.
//
import UIKit
import Foundation

class RandomPicturesListAssembly {
    func create() -> UINavigationController {
        let randomPicturesVC = RandomPicturesListViewController()
        let navigationVC = UINavigationController(rootViewController: randomPicturesVC)
        let router = RandomPicturesListRouter(navigationController: navigationVC)
        let presenter = RandomPicturesListPresenter(
            view: randomPicturesVC,
            router: router,
            picturesStorage: PictureStorage(),
            picturesProvider: RandomPicturesService()
        )
        randomPicturesVC.presenter = presenter

        return navigationVC
    }
}
