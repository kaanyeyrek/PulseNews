//
//  FavoritesReusableCell.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/9/23.
//

import UIKit
import SDWebImage

class FavoritesReusableCell: UICollectionViewCell {
    static let identifier = "FavoritesReusableCell"
    
    private let imageView = NewsCustomImage(frame: .zero)
    private let titleLabel = NewsHeaderCustomLabel(alignment: .left, fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayout()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(systemName: "photo")
        titleLabel.text = ""
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubviews() {
        self.addSubview(imageView)
        self.addSubview(titleLabel)
    }
    private func setLayout() {
        imageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 10, left: 5, bottom: 10, right: 5), size: .init(width: 50, height: 120))
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30).isActive = true

        titleLabel.anchor(top: imageView.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 10), size: .init(width: 20, height: 70))
        titleLabel.numberOfLines = 0
    }
    func configure(with model: NewsPresentation) {
        titleLabel.text = model.title
        if let imageURL = model.urlToImage {
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
            imageView.sd_imageTransition = .fade
            imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: "photo")?.withRenderingMode(.alwaysOriginal))
        }
    }
}
