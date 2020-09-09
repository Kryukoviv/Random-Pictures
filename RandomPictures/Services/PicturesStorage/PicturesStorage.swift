//
//  PicturesStorage.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 08/09/2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation
import RealmSwift

class PictureStorage {
    private let realm = try! Realm()
    
    func savePicture(_ picture: Picture) throws {
        do {
            try realm.write  {
                realm.add(picture.pictureObject)
            }
        } catch {
            print(error)
        }
    }
    
    func removePicture(_ picture: Picture) throws {
        let objects = realm.objects(PictureObject.self)
        if let pictureToDelete = objects.first(where: { $0.id == picture.id }) {
            do {
                try realm.write {
                    realm.delete(pictureToDelete)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func loadPictures() -> [Picture] {
        return realm.objects(PictureObject.self).map { $0.picture }
    }
}
