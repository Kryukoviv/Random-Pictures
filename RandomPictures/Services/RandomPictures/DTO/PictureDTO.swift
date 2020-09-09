//
//  ImageDTO.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 06/09/2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

struct PictureDTO: Decodable {
    let id: String
    let author: String
    let width: Double
    let height: Double
    /// Написать на английском, особенности этого поля
    let url: String
    ///
    let downloadURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadURL = "download_url"
    }
}
