//
//  Picture.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 07/09/2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation
import RealmSwift

struct Picture {
    let id: String
    let url: URL?
    let pictureData: Data?
    let author: String
    let isFavorite: Bool
    
    init(id: String, url: URL?, pictureData: Data?, isFavorite: Bool, author: String) {
        self.id = id
        self.url = url
        self.author = author
        self.isFavorite = isFavorite
        self.pictureData = pictureData
    }
    
    init?(pictureDTO: PictureDTO) {
        guard
            let url = URL(string: pictureDTO.downloadURL),
            let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else {
            return nil
        }
        
        let pathComponents = urlComponents.path.split(separator: "/")
        
        guard
            let scheme = urlComponents.scheme,
            let host = urlComponents.host,
            let baseURL = URL(string: scheme + "://" + host),
            pathComponents.count > 1
        else {
            return nil
        }
        
        let newURL = baseURL
            .appendingPathComponent(String(pathComponents[0]))
            .appendingPathComponent(String(pathComponents[1]))
            .appendingPathComponent("500")
            
        self.url = newURL
        id = pictureDTO.id
        author = pictureDTO.author
        pictureData = nil
        isFavorite = false
    }
    
    var pictureObject: PictureObject {
        let pictureObject = PictureObject()
        pictureObject.id = id
        pictureObject.pictureData = pictureData
        pictureObject.author = author
        return pictureObject
    }
    
    func copy(with isFavorite: Bool) -> Picture {
        Picture(id: id, url: url, pictureData: pictureData, isFavorite: isFavorite, author: author)
    }
}
