//
//  SearchViewController.swift
//  Foodies
//
//  Created by Kaan Yeyrek on 12/31/22.
//

import UIKit

protocol SearchViewInterface: AnyObject {
    func setUI()
    func configureTableView()
    func addSubviews()
    func setLayout()
    func handleOutputs(_ output: SearchViewModelOutput)
    func tableReload()
    func setIndicator(isLoad: Bool)
    func setNavBar()
}

final class SearchViewController: UIViewController {
//MARK: - Injections
    private lazy var viewModel: SearchViewModelInterface = SearchViewModel()
//MARK: - UI Elements
    private var table = UITableView()
    private var indicator = UIActivityIndicatorView()
    private var timer: Timer?
//MARK: - UI Components
    private var news = [NewsPresentation]()
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        self.showEmptyStateView(with: "Please enter some text to search for news!", at: self.view)
    }
}
//MARK: - SearchView Interface
extension SearchViewController: SearchViewInterface {
    func setUI() {
        view.backgroundColor = .systemBackground
    }
    func configureTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        table.keyboardDismissMode = .interactive
    }
    func addSubviews() {
        view.addSubview(table)
        view.addSubview(indicator)
    }
    func setLayout() {
        table.frame = view.bounds
        indicator.centerInSuperView(size: .init(width: 300, height: 300))
    }
    func setIndicator(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    func tableReload() {
        table.reloadData()
    }
    func setNavBar() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for an news"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    func handleOutputs(_ output: SearchViewModelOutput) {
        switch output {
        case .didFailWithError(let title, let message):
            print(title, message)
        case .didUploadPresentation(let news):
            self.news = news
            tableReload()
        case .showEmptyView(let message):
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, at: self.view)
            }
        case .removeEmptyView:
            self.removeEmptyStateView()
        }
    }
}
//MARK: - UITableViewData Source Methods
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.configure(model: news[indexPath.row])
        return cell
    }
}
//MARK: - UITableViewDelegate Methods
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(120)
    }
}
//MARK: - UISearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
                self.indicator.stopAnimating()
            }
        }
        indicator.startAnimating()
        timer?.invalidate()
        viewModel.newSearch()
        guard let query = searchBar.text, !query.isEmpty else {
            news.removeAll()
            tableReload()
            showEmptyStateView(with: "Please enter some text to search for news!", at: self.view)
            return
         }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.viewModel.searchData(with: query)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        news.removeAll()
        indicator.stopAnimating()
        tableReload()
        self.showEmptyStateView(with: "Please enter some text to search for news!", at: self.view)
    }
}



