//
//  RandomPicturesProvider.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 03/09/2020.
//  Copyright © 2020 User. All rights reserved.
//
import Alamofire
import Foundation

protocol RandomPicturesProvider {
    func loadPictures(page: Int, countPerPage: Int, completion: @escaping (Swift.Result<[PictureDTO], AFError>) -> Void)
}

class RandomPicturesService: RandomPicturesProvider {
    func loadPictures(page: Int, countPerPage: Int, completion: @escaping (Swift.Result<[PictureDTO], AFError>) -> Void) {
       AF
        .request("https://picsum.photos/v2/list?page=\(page)&limit=\(countPerPage)")
        .responseDecodable(of: [PictureDTO].self) { response in
            completion(response.result)
        }
    }
}
