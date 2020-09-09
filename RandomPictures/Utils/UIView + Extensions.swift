//
//  UIView+Extensions.swift
//  Swift-Tutorial
//
//  Created by Igor Kryukov on 04.04.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    func addSubviews(_ views: UIView...) -> UIView {
        views.forEach(addSubview)
        return self
    }
}

