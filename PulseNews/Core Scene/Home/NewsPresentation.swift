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
    let publishDate: String
    let sourceName: String
    let content: String?
    
init(model: NewCasts) {
        self.title = model.title
        self.newsDescription = model.description
        self.urlToImage = model.image_url
        self.publishDate = model.pubDate
        self.sourceName = model.source_id
        self.content = ""
    }
}
