//
//  PictureObject.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 08/09/2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation
import RealmSwift

class PictureObject: Object {
    @objc dynamic var id = ""
    @objc dynamic var pictureData: Data? = nil
    @objc dynamic var author = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var picture: Picture {
        Picture(id: id, url: nil, pictureData: pictureData, isFavorite: true, author: author)
    }
}
