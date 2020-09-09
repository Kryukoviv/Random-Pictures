//
//  RandomPicturesListViewController.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 26/08/2020.
//  Copyright © 2020 User. All rights reserved.
//
import UIKit
import Foundation

class RandomPicturesListViewController: UIViewController {
    var presenter: PicturesListPresenterProtocol!
    
    var cellModels: [PictureCell.Model] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(cellClass: PictureCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        makeConstraints()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension RandomPicturesListViewController {
    func showData(cellModels: [PictureCell.Model]) {
        self.cellModels = cellModels
    }
}

extension RandomPicturesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: PictureCell.self, for: indexPath)
        cell.configure(with: cellModels[indexPath.row])
        cell.delegate = self
        cell.selectionStyle = .none
        if indexPath.row == cellModels.count - 1 {
            presenter.loadMore()
        }
        return cell
    }
}

extension RandomPicturesListViewController: PictureCellDelegate {
    func didTapFavoriteButton(id: String, imageData: Data?) {
        presenter.didTapFavoriteButton(pictureID: id, imageData: imageData)
    }
}
