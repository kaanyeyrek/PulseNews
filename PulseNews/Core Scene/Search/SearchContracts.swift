//
//  SearchContracts.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/8/23.
//

import Foundation

enum SearchViewModelOutput {
    case didFailWithError(title: String, message: String)
    case didUploadPresentation(news: [NewsPresentation])
    case showEmptyView(message: String)
    case removeEmptyView
}
