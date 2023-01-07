//
//  EmptyView.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/7/23.
//

import UIKit

class EmptyView: UIView {
    
    let headerLabel = NewsHeaderCustomLabel(alignment: .center, fontSize: 30)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(message: String) {
        self.init(frame: .zero)
        headerLabel.text = message
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        addSubview(headerLabel)
        headerLabel.numberOfLines = 0
        headerLabel.textColor = .secondaryLabel
        headerLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: .init(width: 100, height: 200))
        headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
    }
}
