//
//  NewsPresentation.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/4/23.
//

import Foundation

struct NewsPresentation {
    let title: String
    let newsDescription: String?
    let urlToImage: String?
    let sourceName: String
    
init(model: NewCasts) {
        self.title = model.title
        self.newsDescription = model.description
        self.urlToImage = model.image_url
        self.sourceName = model.source_id
    }
init(model: NewsData) {
        self.title = model.title!
        self.newsDescription = model.descriptions
        self.urlToImage = model.imageURL
        self.sourceName = model.source!
    }
}
