//
//  HomeViewModel.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/3/23.
//

import Foundation

protocol HomeViewModelInterface {
    func viewDidLoad()
    func fetch()
    func notify(_ output: HomeViewModelOutput)
    func changeLoading()
    var numberOfRowsInSections: Int { get }
    func viewWillAppear()
    func didPullToRefresh()
    func didSelectRowAt(at index: Int)
    func didTapSortButton()
    func changeCategory(category: NewsCategories)
}

final class HomeViewModel {
    private weak var view: HomeViewInterface?
    private var newService: NewsServiceInterface
    private var currentPage: Int = 1
    private var selectedCategory: NewsCategories = .top
    private var news: [NewCasts] = []
    private var isLoading = false
    private var moreNews = true
    
    init(view: HomeViewInterface, newService: NewsServiceInterface = NewsService(service: CoreService())) {
        self.newService = newService
        self.view = view
    }
}
//MARK: - HomeViewModel Interface
extension HomeViewModel: HomeViewModelInterface {
    // Lifecycle
    func viewWillAppear() {
        view?.setNavigationTitle()
    }
    func viewDidLoad() {
        view?.setSubviews()
        view?.setLayout()
        view?.setTableView()
        view?.setRefreshControl()
        view?.setBarItem()
        fetch()
    }
    func changeLoading() {
        isLoading = !isLoading
        view?.changeLoading(isLoad: isLoading)
    }
    func didPullToRefresh() {
        view?.beginRefreshing()
        news.removeAll()
        currentPage += 1
        fetch()
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: view!.endRefreshing)
    }
    func fetch() {
        changeLoading()
        newService.fetchNews(endpoint: .fetchNews(category: selectedCategory, page: currentPage)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.changeLoading()
                switch result {
                case .success(let news):
                    self.updateData(with: news)
                case .failure(let error):
                    self.notify(.failedUpdateData(message: error.rawValue, title: "Failed"))
               }
            }
        }
    }
    func updateData(with news: News) {
        if news.results.count <= 0 {
            moreNews = false
        }
        self.news.append(contentsOf: news.results)
        self.news = self.news.removeDuplicates()
        let news = self.news.map({
            NewsPresentation(model: $0)})
        self.notify(.didUploadNewsWithPresentation(news: news))
        if self.news.isEmpty {
            notify(.empty(message: "Sorry, there is currently no news in the \(selectedCategory.rawValue.capitalized) category, please try again later."))
        } else {
            notify(.removeEmpty)
        }
    }
    var numberOfRowsInSections: Int {
        return news.count
    }
    func didSelectRowAt(at index: Int) {
        let viewModel = HomeDetailViewModel(news: news[index])
        view?.navigate(route: .detail(viewModel: viewModel))
    }
    // Helper
    func notify(_ output: HomeViewModelOutput) {
        view?.handleOutputs(output)
    }
    func didTapSortButton() {
        view?.navigate(route: .sort)
    }
    func changeCategory(category: NewsCategories) {
        news.removeAll()
        currentPage = 1
        selectedCategory = category
        moreNews = true
        fetch()
    }
}
