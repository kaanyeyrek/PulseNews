//
//  NewsHeaderCustomLabel.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/5/23.
//

import UIKit

class NewsHeaderCustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(alignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        textAlignment = alignment
        font = .systemFont(ofSize: fontSize, weight: .bold)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        numberOfLines = 0
        lineBreakMode = .byTruncatingTail
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.95
    }
    
}
