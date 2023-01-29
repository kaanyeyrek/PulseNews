//
//  MockHomeViewController.swift
//  PulseNewsTests
//
//  Created by Kaan Yeyrek on 1/11/23.
//

@testable import PulseNews

final class MockHomeViewController: HomeViewInterface {
    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0
    var outputs: [HomeViewModelOutput] = []
    
    var detailRouteCalled: Bool = false
    var detailRouteCalledCount: Int = 0
    
    var invokeChangeLoading = false
    var invokeChangeLoadingCount = 0
    var changeLoadingParameters: (isLoad: Bool, Void)?
    var changeLoadingParametersList = [(isLoad: Bool, Void)]()
    
    var detailParameters: (viewmodel: HomeDetailViewModelInterface, Void)?
    var detailParametersList = [(viewmodel: HomeDetailViewModelInterface, Void)]()

    func setTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }
    
    var invokedBeginRefreshing = false
    var invokedBeginRefreshingCount = 0
    
    func beginRefreshing() {
        invokedBeginRefreshing = true
        invokedBeginRefreshingCount += 1
    }
    var invokedEndRefreshing = false
    var invokedEndRefreshingCount = 0
    
    func endRefreshing() {
        invokedEndRefreshing = true
        invokedEndRefreshingCount += 1
    }
    var invokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }
    func setSubviews() {
        
    }
    func setLayout() {
        
    }
    func changeLoading(isLoad: Bool) {
        invokeChangeLoading = true
        invokeChangeLoadingCount += 1
        changeLoadingParameters = (isLoad: isLoad, ())
        changeLoadingParametersList.append((isLoad: isLoad, ()))
    }
    func setNavigationTitle() {
        
    }
    func setRefreshControl() {
        
    }
    func setBarItem() {
        
    }
    func handleOutputs(_ output: HomeViewModelOutput) {
        outputs.append(output)
    }
    func navigate(route: HomeViewModelRoute) {
        switch route {
        case .detail(let viewModel):
            detailRouteCalled = true
            detailRouteCalledCount += 1
            detailParameters = (viewmodel: viewModel, ())
            detailParametersList.append((viewmodel: viewModel, ()))
        case .sort:
            break
        }
    }
}
