//
//  NewsSourceCustomLabel.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/5/23.
//

import UIKit

class NewsSourceCustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(alignment: NSTextAlignment) {
        self.init(frame: .zero)
        textAlignment = alignment
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.95
        font = .preferredFont(forTextStyle: .subheadline)
        textColor = .secondaryLabel
    }

}
