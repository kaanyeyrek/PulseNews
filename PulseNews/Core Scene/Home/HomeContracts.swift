//
//  HomeContracts.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/4/23.
//

import Foundation

enum HomeViewModelOutput {
    case failedUpdateData(message: String, title: String)
    case didUploadNewsWithPresentation(news: [NewsPresentation])
}
enum HomeViewModelRoute {
    case detail(viewModel: HomeDetailViewModelInterface)
}
