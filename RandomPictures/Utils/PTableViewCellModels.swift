//
//  PTableViewCellModels.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 07/09/2020.
//  Copyright © 2020 User. All rights reserved.
//


import UIKit

protocol PTableViewCellAnyModel {
    var rowHeight: CGFloat { get }
    static var cellAnyType: UITableViewCell.Type { get }

    func configureAny(cell: UITableViewCell)
}

protocol PTableViewCellModel: PTableViewCellAnyModel {
    associatedtype CellType: UITableViewCell
    func configure(cell: CellType)
}

extension PTableViewCellModel {
    static var cellAnyType: UITableViewCell.Type {
       return CellType.self
    }
    
    func configureAny(cell: UITableViewCell) {
        guard let cellWithType = cell as? CellType else {
            assertionFailure("Could not cast cell of type \(type(of: cell)) to \(String(describing: CellType.self))")
            return
        }

        configure(cell: cellWithType)
    }
    
    var rowHeight: CGFloat {
       return UITableView.automaticDimension
    }
}
