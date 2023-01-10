//
//  FavoritesContracts.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/9/23.
//

import Foundation

enum FavoritesViewModelOutput {
    case didUploadWithFavorites(with: [NewsPresentation])
    case emptyView(message: String)
    case removeEmptyView
    case isDeleteAll(isEnabled: Bool)
}
enum FavoritesViewRoute {
    case detail(viewModel: HomeDetailViewModelInterface)
}
