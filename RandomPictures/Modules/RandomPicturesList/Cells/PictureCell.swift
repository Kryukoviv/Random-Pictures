//
//  TableViewCell.swift
//  RandomPictures
//
//  Created by Igor Kryukov on 07/09/2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import SnapKit

protocol PictureCellDelegate: AnyObject {
    func didTapFavoriteButton(id: String, imageData: Data?)
}

class PictureCell: UITableViewCell {
    let pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "heart_filled"), for: .selected)
        button.setImage(#imageLiteral(resourceName: "heart_empty"), for: .normal)
        return button
    }()
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "comfortaa", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    weak var delegate: PictureCellDelegate?
    
    private var id: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            pictureImageView,
            favoriteButton,
            authorLabel
        )
        
        makeConstraints()
        
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        pictureImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().inset(8)
            make.height.equalTo(pictureImageView.snp.width)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(8)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(pictureImageView.snp.bottom)
            make.right.bottom.equalToSuperview().inset(8)
            make.left.equalTo(authorLabel.snp.right).inset(16)
        }
    }
    
    @objc
    private func didTapFavoriteButton(_ sender: UIButton) {
        delegate?.didTapFavoriteButton(
            id: id ?? "",
            imageData: pictureImageView.image?.pngData()
        )
    }
}

extension PictureCell {
    struct Model {
        let id: String
        let pictureURL: URL?
        let imageData: Data?
        let isFavorite: Bool
        let author: String
    }
    
    func configure(with model: Model) {
        authorLabel.text = model.author
        favoriteButton.isSelected = model.isFavorite
        if let imageData = model.imageData {
            pictureImageView.image = UIImage(data: imageData, scale: 1.0)
        } else {
            pictureImageView.load(fromUrl: model.pictureURL)
        }
        self.id = model.id
    }
}
