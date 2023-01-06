//
//  HTTPEndpoint.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/2/23.
//

import Foundation

protocol HTTPEndPoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var query: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}

extension HTTPEndPoint {
    var scheme: String {
        return "https"
    }
    var host: String {
        return "newsdata.io"
    }
    var method: HTTPMethod {
        return .get
    }
}
