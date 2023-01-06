//
//  CustomReusableButton.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/5/23.
//

import UIKit

class CustomReusableButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        setTitleColor(.label, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        layer.cornerRadius = 20
    }
}
