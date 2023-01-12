//
//  MockService.swift
//  PulseNewsTests
//
//  Created by Kaan Yeyrek on 1/12/23.
//

import Foundation
@testable import PulseNews

final class MockService: NewsServiceInterface {
    var isFetchNewsCalled = false
    var isFetchNewsCount = 0
    var isSearchNewsCalled = false
    var isSearchCount = 0
    
    func fetchNews(endpoint: NewsEndPoint, completion: @escaping (Result<News, NetworkError>) -> Void) {
        isFetchNewsCalled = true
        isFetchNewsCount += 1
        }
    func search(endpoint: NewsEndPoint, completion: @escaping (Result<News, NetworkError>) -> Void) {
        isSearchNewsCalled = true
        isSearchCount += 1
    }
}
