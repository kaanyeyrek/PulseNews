//
//  CategoriesCollectionViewCell.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/6/23.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    private let categoriesLabel = NewsHeaderCustomLabel(alignment: .center, fontSize: 20)
    private let categoriesImage = NewsCustomImage()
    static let identifier = "CategoriesCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setLayout()
        setCustomUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        categoriesLabel.text = ""
        categoriesImage.image = UIImage(systemName: "photo")
    }
    private func setSubviews() {
        self.addSubview(categoriesImage)
        self.addSubview(categoriesLabel)
    }
    private func setCustomUI() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 20
    }
    private func setLayout() {
        categoriesImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 0, right: 15), size: .init(width: self.frame.width, height: 130))
        categoriesImage.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        categoriesLabel.anchor(top: categoriesImage.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 50))
        categoriesLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 70).isActive = true
    }
    func configure(model: CategoriesModel) {
        categoriesLabel.text = model.title.capitalized
        categoriesImage.image = UIImage(named: model.image)?.withRenderingMode(.alwaysOriginal)
        }
    }

