//
//  HomeDetailViewModel.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/5/23.
//

import Foundation
import ProgressHUD

protocol HomeDetailViewModelInterface {
    var view: HomeDetailViewInterface? { get set }
    func viewWillAppear()
    func viewDidLoad()
    func loadPresentation()
    func setSafariWebPage()
    func saveTapped(isSelected: Bool)
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
        view?.saveButtonConfigure()
        
    }
    func loadPresentation() {
        let presentation = NewsPresentation(model: news)
        notify(.load(presentation))
        notify(.isSaved(checkSaveInfo()))
    }
    func setSafariWebPage() {
        notify(.showMorePage(url: news.link))
    }
    func saveTapped(isSelected: Bool) {
        if isSelected {
            CoreDataManager().delete(model: news)
            ProgressHUD.showSucceed("Successfully deleted!", delay: 1.5)
        } else {
            CoreDataManager().save(model: news)
            ProgressHUD.showSucceed("Successfully saved!", delay: 1.5)
        }
    }
    //Helper
    private func notify(_ output: HomeDetailOutput) {
        view?.setHandleOutput(output)
    }
    //Helper
    private func checkSaveInfo() -> Bool {
        let savedNews = CoreDataManager().fetch()
        for savedNew in savedNews {
            if savedNew.title == news.title {
                return true
            }
        }
        return false
    }
}
