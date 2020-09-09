//
//  UITableView+Extensions.swift
//  Swift-Tutorial
//
//  Created by Igor Kryukov on 4/2/19.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

extension UITableView {
        
    func register<Cell: UITableViewCell>(cellClass: Cell.Type) {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(
        cellClass: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        let identifier = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
    }
}

