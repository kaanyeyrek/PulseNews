//
//  HomeViewController.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 12/31/22.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    func setTableView()
    func setSubviews()
    func setLayout()
    func changeLoading(isLoad: Bool)
    func reloadData()
    func setNavigationTitle()
    func setRefreshControl()
    func setBarItem()
    func beginRefreshing()
    func endRefreshing()
    func handleOutputs(_ output: HomeViewModelOutput)
    func navigate(route: HomeViewModelRoute)
}

final class HomeViewController: UIViewController {
//MARK: - Injections
    private lazy var viewModel: HomeViewModelInterface = HomeViewModel(view: self)
//MARK: - UI Elements
    private var table = UITableView()
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
//MARK: - UI Components
    private var news = [NewsPresentation]()
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
//MARK: - @objc actions
    @objc private func didPullToRefresh() {
        viewModel.didPullToRefresh()
    }
    @objc private func didTapSortButton() {
        viewModel.didTapSortButton()
    }
}
//MARK: - HomeViewInterface Delegate
extension HomeViewController: HomeViewInterface {
    func navigate(route: HomeViewModelRoute) {
        switch route {
        case .detail(let viewModel):
            let vc = DetailBuilder.make(viewModel: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        case .sort:
            let vc = SortViewController()
            vc.delegate = self
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }
    }
    func handleOutputs(_ output: HomeViewModelOutput) {
        switch output {
        case .didUploadNewsWithPresentation(let news):
                self.news = news
                reloadData()
        case .failedUpdateData(let message, let title):
            print(message, title)
        case .empty(let message):
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, at: self.view)
            }
        case .removeEmpty:
            self.removeEmptyStateView()
        }
    }
    func beginRefreshing() {
        table.refreshControl?.beginRefreshing()
    }
    func endRefreshing() {
        table.refreshControl?.endRefreshing()
    }
    func setSubviews() {
        view.addSubview(table)
        view.addSubview(indicator)
    }
    func setTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    func setLayout() {
        table.frame = view.bounds
        indicator.centerInSuperView(size: .init(width: 200, height: 200))
        indicator.startAnimating()
    }
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    func reloadData() {
        self.table.reloadData()
    }
    func setNavigationTitle() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func setRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.table.refreshControl = refresh
    }
    func setBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "circle.grid.2x2"), style: .done, target: self, action: #selector(didTapSortButton))
    }
}
//MARK: - UITableViewDataSource Methods
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSections
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        let model = news[indexPath.row]
        cell.configure(model: model)
        return cell
    }
}
//MARK: - UITableViewDelegate Methods
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
//MARK: - SortView Delegate
extension HomeViewController: SortViewInterface {
    func didTapCategory(category: NewsCategories) {
        if !news.isEmpty {
            table.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        viewModel.changeCategory(category: category)
    }
}
