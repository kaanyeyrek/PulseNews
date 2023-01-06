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
    func handleOutputs(_ output: HomeViewModelOutput)
    func navigate(route: HomeViewModelRoute)
    func changeLoading(isLoad: Bool)
    func reloadData()
    func setNavigationTitle()
    func setRefreshControl()
}

final class HomeViewController: UIViewController {
    private lazy var viewModel: HomeViewModelInterface = HomeViewModel(view: self)
    private var table = UITableView()
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var news = [NewsPresentation]()
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        viewModel.fetch()
    }
//MARK: - @objc action
    @objc private func didPullToRefresh() {
        self.table.refreshControl?.beginRefreshing()
        viewModel.didPullToRefresh()
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: self.table.refreshControl!.endRefreshing)
    }
}
//MARK: - HomeViewInterface Delegate
extension HomeViewController: HomeViewInterface {
    func navigate(route: HomeViewModelRoute) {
        switch route {
        case .detail(let viewModel):
            let vc = DetailBuilder.make(viewModel: viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func handleOutputs(_ output: HomeViewModelOutput) {
        switch output {
        case .didUploadNewsWithPresentation(let news):
                self.news = news
                reloadData()
        case .failedUpdateData(let message, let title):
            print(message, title)
        }
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
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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

