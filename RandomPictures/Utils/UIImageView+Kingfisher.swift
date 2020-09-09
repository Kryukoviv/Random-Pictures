//
//  UIImageView+Kingfisher.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 07/09/2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    enum ImageLoadingError: Error {
        case localImageNotFoundInBundle
    }

    func load(
        fromUrl: URL?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        indicatorType: IndicatorType = .activity,
        completion: ((Result<UIImage, Error>) -> Void)? = nil
    ) {
        kf.indicatorType = indicatorType
        load(
            from: fromUrl,
            placeholder: placeholder,
            options: options,
            completion: completion
        )
    }

    private func load(
        from url: URL?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        completion: ((Result<UIImage, Error>) -> Void)? = nil
    ) {
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options
        ) { result in
            switch result {
            case let .success(successResult):
                self.image = successResult.image
                completion?(.success(successResult.image))
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
}
