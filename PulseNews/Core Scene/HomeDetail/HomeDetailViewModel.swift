//
//  HomeDetailViewModel.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/5/23.
//

import Foundation

protocol HomeDetailViewModelInterface {
    var view: HomeDetailViewInterface? { get set }
    func viewWillAppear()
    func viewDidLoad()
    func loadPresentation()
    func setSafariWebPage()
}

final class HomeDetailViewModel {
    weak var view: HomeDetailViewInterface?
    private var news: NewCasts
    init(news: NewCasts) {
        self.news = news
    }
}
//MARK: - HomeDetailViewModel Interface
extension HomeDetailViewModel: HomeDetailViewModelInterface {
// LifeCycle
    func viewWillAppear() {
        view?.setNavigationTitle()
    }
    func viewDidLoad() {
        view?.setAddSubviews()
        view?.setUI()
        view?.setLayout()
        view?.setTarget()
        
    }
    func loadPresentation() {
        let presentation = NewsPresentation(model: news)
        notify(.load(presentation))
    }
    func setSafariWebPage() {
        notify(.showMorePage(url: news.link))
    }
    // Helper
    private func notify(_ output: HomeDetailOutput) {
        view?.setHandleOutput(output)
    }
}
