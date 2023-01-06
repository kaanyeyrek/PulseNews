//
//  NewsService.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/3/23.
//

import Foundation

protocol NewsServiceInterface {
    func fetchNews(endpoint: NewsEndPoint, completion: @escaping (Result<News, NetworkError>) -> Void)
    func search(endpoint: NewsEndPoint, completion: @escaping (Result<News, NetworkError>) -> Void)
}

final class NewsService: NewsServiceInterface {
    private var service: CoreServiceProtocol!
    
    init(service: CoreServiceProtocol!) {
        self.service = service
    }
    func fetchNews(endpoint: NewsEndPoint, completion: @escaping (Result<News, NetworkError>) -> Void) {
        service.fetch(endPoint: endpoint) { (result: Result<News, NetworkError>) in
            completion(result)
        }
    }
    func search(endpoint: NewsEndPoint, completion: @escaping (Result<News, NetworkError>) -> Void) {
        service.fetch(endPoint: endpoint) { (result: Result<News, NetworkError>) in
            completion(result)
    }
}
 }
