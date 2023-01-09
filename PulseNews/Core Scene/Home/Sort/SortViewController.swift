//
//  SortViewController.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/6/23.
//

import UIKit

protocol SortViewInterface: AnyObject {
    func didTapCategory(category: NewsCategories)
}

class SortViewController: UIViewController {
//MARK: - UI Elements
    private var collection: UICollectionView!
    private var customButton = CustomReusableButton(title: "< Back", backgroundColor: .secondarySystemBackground)
    private let headerLabel = NewsHeaderCustomLabel(alignment: .center, fontSize: 20)
//MARK: - Injections
    weak var delegate: SortViewInterface!
//MARK: - Components
    private var categories: [NewsCategories] = [.business, .top, .world, .entertainment, .environment, .food, .health, .politics, .science, .sports, .technology]
    private var categoriesModel: [CategoriesModel] = []
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        setAddSubviews()
        addTarget()
        setUI()
        setLayout()
        categoriesModel = setData()
    }
}
//MARK: - Configure UI
extension SortViewController {
//MARK: - @objc actions
    @objc private func didTapBackButton() {
        dismiss(animated: true)
    }
    private func setUI() {
        view.backgroundColor = .systemBackground
        headerLabel.text = "Categories"
    }
    private func setCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collection = collection else { return }
        collection.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        collection.showsVerticalScrollIndicator = true
        collection.delegate = self
        collection.dataSource = self
    }
    private func setAddSubviews() {
        view.addSubview(collection)
        view.addSubview(customButton)
        view.addSubview(headerLabel)
    }
    private func addTarget() {
        customButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    private func setLayout() {
        collection.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: view.frame.height-100))
        customButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0), size: .init(width: 70, height: 40))
        customButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        headerLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 100, height: 50))
        headerLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
    }
    private func setData() -> [CategoriesModel] {
        let category1 = CategoriesModel(title: "business", image: "business")
        let category2 = CategoriesModel(title: "top", image: "top")
        let category3 = CategoriesModel(title: "world", image: "world")
        let category4 = CategoriesModel(title: "entertainment", image: "entertainment")
        let category5 = CategoriesModel(title: "environment", image: "environment")
        let category6 = CategoriesModel(title: "food", image: "food")
        let category7 = CategoriesModel(title: "healt", image: "healt")
        let category8 = CategoriesModel(title: "politics", image: "politics")
        let category9 = CategoriesModel(title: "science", image: "science")
        let category10 = CategoriesModel(title: "sports", image: "sports")
        let category11 = CategoriesModel(title: "technology", image: "technology")
        return [category1, category2, category3, category4, category5, category6, category7, category8, category9, category10, category11]
    }
}
//MARK: - UICollectionViewDataSource
extension SortViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        cell.configure(model: categoriesModel[indexPath.item])
        return cell
    }
}
//MARK: - UICollectionViewDelegate
extension SortViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didTapCategory(category: categories[indexPath.item])
        dismiss(animated: true)
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension SortViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 15) / 2
        return .init(width: width-10, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}
