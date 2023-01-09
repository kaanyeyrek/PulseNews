//
//  NewsEndPoint.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/3/23.
//

import Foundation

enum NewsEndPoint: HTTPEndPoint {
    
    case fetchNews(category: NewsCategories, page: Int)
    case searchNews(q: String, page: Int)
    
    var path: String {
        return Paths.latest
    }
    var query: [URLQueryItem] {
        switch self {
        case .fetchNews(let category, let page):
            return [URLQueryItem(name: "apiKey", value: NetworkHelper.apiKey),
                    URLQueryItem(name: "language", value: Locale.current.language.languageCode?.identifier),
                    URLQueryItem(name: "category", value: category.rawValue),
                    URLQueryItem(name: "page", value: String(page))
            ]
        case .searchNews(let q, let page):
            return [URLQueryItem(name: "apiKey", value: NetworkHelper.apiKey),
                    URLQueryItem(name: "language", value: Locale.current.language.languageCode?.identifier),
                    URLQueryItem(name: "page", value: String(page)),
                    URLQueryItem(name: "q", value: q)
            ]
        }
    }
}
