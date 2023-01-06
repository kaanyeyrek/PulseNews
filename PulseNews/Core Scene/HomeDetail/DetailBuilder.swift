//
//  DetailBuilder.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/5/23.
//

import Foundation

final class DetailBuilder {
    static func make(viewModel: HomeDetailViewModelInterface) -> HomeDetailViewController {
        let vc = HomeDetailViewController(viewModel: viewModel)
        return vc
    }
}
