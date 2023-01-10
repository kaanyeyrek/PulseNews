//
//  News.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/2/23.
//

import Foundation

struct News: Decodable {
    let status: String
    let totalResults: Int
    let results: [NewCasts]
}
// MARK: - NewCasts
struct NewCasts: Decodable, Equatable {
    let title: String
    let link: String
    let description: String?
    let image_url: String?
    let source_id: String
}
