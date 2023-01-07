//
//  NewsTableViewCell.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/5/23.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    private lazy var image = NewsCustomImage()
    private let headLabel = NewsHeaderCustomLabel(alignment: .left, fontSize: 15)
    private let sourceLabel = NewsSourceCustomLabel(alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = UIImage(systemName: "photo")
        headLabel.text = ""
        sourceLabel.text = ""
    }
    private func setSubviews() {
        self.addSubview(image)
        self.addSubview(headLabel)
        self.addSubview(sourceLabel)
    }
    private func setLayout() {
        image.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 10, right: 10), size: .init(width: 140, height: 50))
        image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        headLabel.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 40, right: 10), size: .init(width: 50, height: 30))
        headLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 80).isActive = true
        
        sourceLabel.anchor(top: headLabel.bottomAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 5, right: 0), size: .init(width: 50, height: 30))
        sourceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 85).isActive = true
    }
    func configure(model: NewsPresentation) {
        headLabel.text = model.title
        sourceLabel.text = model.sourceName
        if let imageURL = model.urlToImage {
            image.sd_imageIndicator = SDWebImageActivityIndicator.medium
            image.sd_imageTransition = .fade
            image.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: "photo"))
        }
    }
}
