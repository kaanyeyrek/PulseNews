//
//  SearchViewModel.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/8/23.
//

import Foundation

protocol SearchViewModelInterface {
    var view: SearchViewInterface? { get set }
    func viewDidLoad()
    func searchData(with q: String)
    func updateData(with news: News)
    func changeLoading()
    func newSearch()
    func didPullRefresh()
    func didSelectRowAt(at index: Int)
}

final class SearchViewModel {
    private var query = ""
    private var currentPage = 1
    private var moreNews = true
    private var isLoading = false
    
    weak var view: SearchViewInterface?
    private var service: NewsServiceInterface
    private var news: [NewCasts] = []
    
    init(service: NewsServiceInterface = NewsService(service: CoreService())) {
        self.service = service
    }
}
//MARK: - SearchViewModel Interface
extension SearchViewModel: SearchViewModelInterface {
    //LifeCycle
    func viewDidLoad() {
        view?.setUI()
        view?.configureTableView()
        view?.setRefresh()
        view?.addSubviews()
        view?.setLayout()
        view?.setNavBar()
    }
    //Helper
    func notify(_ output: SearchViewModelOutput) {
        view?.handleOutputs(output)
    }
    func searchData(with q: String) {
        changeLoading()
        query = q
        service.search(endpoint: .searchNews(q: query, page: currentPage)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.changeLoading()
                switch result {
                case .success(let news):
                    self.updateData(with: news)
                case .failure(let error):
                    self.notify(.didFailWithError(title: "Failed", message: error.rawValue))
                }
            }
        }
    }
    func updateData(with news: News) {
        if self.news.count <= 0 {
            self.moreNews = false
        } else {
            self.moreNews = true
        }
        self.news.append(contentsOf: news.results)
        let news = self.news.map({ NewsPresentation(model: $0)})
        self.notify(.didUploadPresentation(news: news))
        if self.news.isEmpty {
            notify(.showEmptyView(message: "No search results for\n\(query)"))
        } else {
            notify(.removeEmptyView)
        }
    }
    func changeLoading() {
        isLoading = !isLoading
        view?.setIndicator(isLoad: isLoading)
    }
    func newSearch() {
        news.removeAll()
        currentPage = 1
    }
    func didPullRefresh() {
        news.removeAll()
        currentPage += 1
        searchData(with: query)
    }
    func didSelectRowAt(at index: Int) {
        let viewModel = HomeDetailViewModel(news: news[index])
        view?.navigate(route: .detail(viewModel: viewModel))
    }
}
