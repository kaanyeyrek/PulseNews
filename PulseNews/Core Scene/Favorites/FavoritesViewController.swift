//
//  CategoriesViewController.swift
//  Foodies
//
//  Created by Kaan Yeyrek on 12/31/22.
//

import UIKit

protocol FavoritesViewInterface: AnyObject {
    func handleOutputs(_ output: FavoritesViewModelOutput)
    func setUI()
    func setLayout()
    func setCollection()
    func reloadCollection()
    func setNavBar()
    func navigate(route: FavoritesViewRoute)
}

class FavoritesViewController: UIViewController {
//MARK: - Injections
    private lazy var viewModel: FavoritesViewModelInterface = FavoritesViewModel()
//MARK: - UI Elements
    private var collection: UICollectionView!
//MARK: - Components
    private var favoritesData = [NewsPresentation]()
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavorites()
        reloadCollection()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
//MARK: - @objc actions
    @objc private func didTapTrashButton() {
        viewModel.didTapTrashButton()
    }
}
//MARK: - FavoritesView Interface
extension FavoritesViewController: FavoritesViewInterface {
    func navigate(route: FavoritesViewRoute) {
        switch route {
        case .detail(let viewModel):
            let vc = DetailBuilder.make(viewModel: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func handleOutputs(_ output: FavoritesViewModelOutput) {
        switch output {
        case .didUploadWithFavorites(let favorites):
            self.favoritesData = favorites
            reloadCollection()
        case .emptyView(let message):
            self.showEmptyStateView(with: message, at: self.view)
        case .removeEmptyView:
            self.removeEmptyStateView()
        case .isDeleteAll(let isEnabled):
            navigationItem.rightBarButtonItem?.isEnabled = isEnabled
        }
    }
    func setUI() {
        view.backgroundColor = .systemBackground
    }
    func setLayout() {
        collection.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: view.frame.height + 100))
        collection.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    func reloadCollection() {
        collection.reloadData()
    }
    func setCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collection = collection else { return }
        collection.register(FavoritesReusableCell.self, forCellWithReuseIdentifier: FavoritesReusableCell.identifier)
        collection.showsVerticalScrollIndicator = true
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
    }
    func setNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapTrashButton))
    }
}
//MARK: - UICollectionView Delegatee
extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(index: indexPath.item)
    }
}
//MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoritesData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: FavoritesReusableCell.identifier, for: indexPath) as! FavoritesReusableCell
        let model = favoritesData[indexPath.item]
        cell.configure(with: model)
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 15) / 2
        return .init(width: width-10, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 10, bottom: 10, right: 10)
    }
}
