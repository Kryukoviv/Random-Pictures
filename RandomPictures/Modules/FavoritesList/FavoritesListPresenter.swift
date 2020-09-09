//
//  FavoritesListPresenter.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 26/08/2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

class FavoritesListPresenter: PicturesListPresenterProtocol {
    weak var view: RandomPicturesListViewController?
    private let router: FavoritesListRouter
    private let storage: PictureStorage
    
    private var pictures: [Picture] = []
    
    init(
        view: RandomPicturesListViewController,
        router: FavoritesListRouter,
        pictureStorage: PictureStorage
    ){
        self.view = view
        self.router = router
        self.storage = pictureStorage
    }
    
    func viewDidLoad() {}
    
    func viewWillAppear() {
        pictures = storage.loadPictures()
        showData()
    }
    
    func loadMore() {}
    
    func didTapFavoriteButton(pictureID: String, imageData: Data?) {
        guard
            let picture = pictures.first(where: { $0.id == pictureID }),
            let index = pictures.firstIndex(where: { $0.id == pictureID })
        else { return }
        
        try? storage.removePicture(picture)
        pictures.remove(at: index)
        showData()
    }
    
    private func showData() {
        self.view?.showData(cellModels: self.pictures.map { picture in
            PictureCell.Model(
                id: picture.id,
                pictureURL: picture.url,
                imageData: picture.pictureData,
                isFavorite: self.pictures.contains(where: {
                    $0.id == picture.id
                }),
                author: picture.author
            )
        })
    }
}
