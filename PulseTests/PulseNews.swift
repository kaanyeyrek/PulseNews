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
    override func tearDown() {
        view = nil
        service = nil
        viewModel = nil
    }
    func test_viewDidLoad_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertTrue(view.changeLoadingParametersList.isEmpty)
        XCTAssertFalse(view.invokeChangeLoading)
        XCTAssertFalse(service.isFetchNewsCalled)
        viewModel.viewDidLoad()
        XCTAssertEqual(view.invokedPrepareTableViewCount, 1)
        XCTAssertEqual(service.isFetchNewsCount, 1)
        XCTAssertEqual(view.invokeChangeLoadingCount, 1)
        XCTAssertEqual(view.changeLoadingParametersList.map(\.isLoad), [true])
    }
    func test_didSelectItem_WithFirstIndex() {
        XCTAssertFalse(view.detailRouteCalled)
        view.outputs.removeAll()
        viewModel.didSelectRowAt(at: 0)
    }
}
