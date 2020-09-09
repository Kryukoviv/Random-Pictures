//
//  RandomPicturesListPresenter.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 26/08/2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

protocol PicturesListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func loadMore()
    func didTapFavoriteButton(pictureID: String, imageData: Data?)
}

class RandomPicturesListPresenter: PicturesListPresenterProtocol {
    private weak var view: RandomPicturesListViewController?
    private let router: RandomPicturesListRouter
    private let picturesProvider: RandomPicturesProvider
    private let picturesStorage: PictureStorage
    private let pageLimit = 10
    private var page = 1

    var pictures: [Picture] = []
    var picturesFromDatabase: [Picture] = []
    
    init(
        view: RandomPicturesListViewController,
        router: RandomPicturesListRouter,
        picturesStorage: PictureStorage,
        picturesProvider: RandomPicturesProvider
    ) {
        self.view = view
        self.router = router
        self.picturesStorage = picturesStorage
        self.picturesProvider = picturesProvider
    }
    
    func viewDidLoad() {
        loadFavoritesPictures()
        downloadPictures()
    }
    
    func viewWillAppear() {
        loadFavoritesPictures()
        showData()
    }
    
    func loadMore() {
        page += 1
        downloadPictures(page: page)
    }
    
    func didTapFavoriteButton(pictureID: String, imageData: Data?) {
        guard let picture = pictures.first(where: { $0.id == pictureID }) else { return }
        guard let pictureIndex = pictures.firstIndex(where: { $0.id == pictureID }) else { return }
        
        if let pictureFromDataBase = picturesFromDatabase.first(where: { $0.id == pictureID }) {
            try? picturesStorage.removePicture(pictureFromDataBase)
        } else {
            let pictureWithData = Picture(
                id: pictureID,
                url: picture.url,
                pictureData: imageData,
                isFavorite: true,
                author: picture.author
            )
            pictures[pictureIndex] = pictureWithData
            picturesFromDatabase.append(pictureWithData)
            try? picturesStorage.savePicture(pictureWithData)
            showData()
        }
    }
        
    private func loadFavoritesPictures() {
        picturesFromDatabase = picturesStorage.loadPictures()
    }
        
    private func downloadPictures(page: Int = 0) {
        picturesProvider.loadPictures(page: page, countPerPage: pageLimit) { [weak self] result in
            switch result {
            case .success(let picturesDTO):
                self?.pictures.append(
                    contentsOf: picturesDTO.compactMap { dto in
                        Picture(pictureDTO: dto)
                    }
                )
                self?.showData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showData() {
        self.view?.showData(cellModels: self.pictures.map { picture in
            PictureCell.Model(
                id: picture.id,
                pictureURL: picture.url,
                imageData: picture.pictureData,
                isFavorite: self.picturesFromDatabase.contains(where: {
                    $0.id == picture.id
                }),
                author: picture.author
            )
        })
    }
}
