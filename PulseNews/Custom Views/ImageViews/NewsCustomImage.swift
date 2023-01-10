//
//  NewsCustomImage.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/5/23.
//

import UIKit

class NewsCustomImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init() {
        self.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        backgroundColor = .systemBackground
        contentMode = .scaleAspectFill
        tintColor = .secondarySystemFill
        layer.cornerRadius = 20
        layer.masksToBounds = true
        clipsToBounds = true
        image = UIImage(systemName: "photo")
    }

}
