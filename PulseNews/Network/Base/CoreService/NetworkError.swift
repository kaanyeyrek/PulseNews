//
//  NetworkError.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/2/23.
//

import Foundation

enum NetworkError: String, Error {
    case badURL
    case badResponse
    case unauthorized
    case unexpectedStatusCode
    case badData
    case decoding
}
