//
//  FavoritesViewModel.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/9/23.
//

import Foundation
import ProgressHUD

protocol FavoritesViewModelInterface {
    var view: FavoritesViewInterface? { get set }
    func viewDidLoad()
    func fetchFavorites()
    func didTapTrashButton()
    func deleteAll()
    func didSelectRowAt(index: Int)
}

final class FavoritesViewModel {
    weak var view: FavoritesViewInterface?
    private let service: CoreDataManagerInterface
    private var newsData = [NewsData]()
    
    init(service: CoreDataManagerInterface = CoreDataManager()) {
        self.service = service
    }
}
//MARK: - FavoritesViewModel Interface
extension FavoritesViewModel: FavoritesViewModelInterface {
    func viewDidLoad() {
        view?.setUI()
        view?.setCollection()
        view?.setLayout()
        view?.setNavBar()
    }
//Helper
    private func notify(_ output: FavoritesViewModelOutput) {
        view?.handleOutputs(output)
    }
    func fetchFavorites() {
        newsData = service.fetch()
        if newsData.isEmpty {
            notify(.isDeleteAll(isEnabled: false))
            notify(.didUploadWithFavorites(with: []))
            notify(.emptyView(message: "You have no saved favorites"))
            return
        }
        notify(.isDeleteAll(isEnabled: true))
        notify(.didUploadWithFavorites(with: newsData.map {
            NewsPresentation(model: $0) }))
            notify(.removeEmptyView)
    }
    func didTapTrashButton() {
        ProgressHUD.showSucceed("Saved news are deleted successfully!", delay: 1.5)
        deleteAll()
    }
    func deleteAll() {
        service.deleteAll()
        fetchFavorites()
    }
    func didSelectRowAt(index: Int) {
        let model = newsData[index]
        let viewModel = HomeDetailViewModel(news: NewCasts(title: model.title ?? "", link: model.link ?? "", description: model.descriptions, image_url: model.imageURL, source_id: model.source ?? ""))
        view?.navigate(route: .detail(viewModel: viewModel))
    }
}
