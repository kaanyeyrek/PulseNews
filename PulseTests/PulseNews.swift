//
//  PulseNewsTests.swift
//  PulseNewsTests
//
//  Created by Kaan Yeyrek on 12/31/22.
//

import XCTest
@testable import PulseNews

final class PulseNews: XCTestCase {
    private var viewModel: HomeViewModel!
    private var view: MockHomeViewController!
    private var service: MockService!

    override func setUp() {
        super.setUp()
        view = .init()
        service = .init()
        viewModel = .init(view: view, newService: service)
    }
    func test_viewDidLoad_InvokesRequiredMethod() {
        //given
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertFalse(view.invokedBeginRefreshing)
        XCTAssertFalse(view.invokedEndRefreshing)
        XCTAssertFalse(view.invokedReloadData)
        XCTAssertFalse(service.isFetchNewsCalled)
        XCTAssertFalse(service.isSearchNewsCalled)
        //when
        viewModel.viewDidLoad()
        //then
        XCTAssertEqual(view.invokedPrepareTableViewCount, 1)
        XCTAssertEqual(service.isFetchNewsCount, 1)
    }
    func testExample() {
        //given
        
        //when
        
        //then
        
    }
}
