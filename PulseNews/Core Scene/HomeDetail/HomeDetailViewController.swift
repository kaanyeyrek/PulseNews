//
//  HomeDetailViewController.swift
//  PulseNews
//
//  Created by Kaan Yeyrek on 1/5/23.
//

import UIKit
import SDWebImage
import SafariServices

protocol HomeDetailViewInterface: AnyObject {
    func setNavigationTitle()
    func setAddSubviews()
    func setUI()
    func setLayout()
    func setTarget()
    func setHandleOutput(_ output: HomeDetailOutput)
    func saveButtonConfigure()
}

final class HomeDetailViewController: UIViewController {
//MARK: - Injections
    private var viewModel: HomeDetailViewModelInterface!
    
    init(viewModel: HomeDetailViewModelInterface!) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - UI Elements
    private var customButton = CustomReusableButton(title: "More...", backgroundColor: .systemGray5)
    private var detailImage = NewsCustomImage()
    private var titleLabel = NewsHeaderCustomLabel(alignment: .left, fontSize: 20)
    private var descriptionLabel = NewsBodyCustomLabel(alignment: .left)
    private var sourceLabel = NewsSourceCustomLabel(alignment: .right)
    private let button = UIButton(type: .system)
//MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
        viewModel.loadPresentation()
    }
//MARK: - @objc action
    @objc private func didTapMoreButton() {
        viewModel.setSafariWebPage()
    }
    @objc private func didTapSaveButton() {
        viewModel.saveTapped(isSelected: button.isSelected)
        button.isSelected.toggle()
    }
}
//MARK: - HomeDetailView Interface
extension HomeDetailViewController: HomeDetailViewInterface {
    func setHandleOutput(_ output: HomeDetailOutput) {
        switch output {
        case .load(let presentation):
            titleLabel.text = presentation.title
            descriptionLabel.text = presentation.newsDescription
            sourceLabel.text = presentation.sourceName
            if let imageURL = presentation.urlToImage {
                detailImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
                detailImage.sd_imageTransition = .fade
                detailImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: "photo"))
            }
        case .showMorePage(let url):
            guard let url = URL(string: url) else { return }

            let configuration = SFSafariViewController.Configuration()
            configuration.entersReaderIfAvailable = true
    
            let vc = SFSafariViewController(url: url, configuration: configuration)
            vc.preferredControlTintColor = .label
            present(vc, animated: true)
        case .isSaved(let saved):
            button.isSelected = saved
        }
    }
    func setNavigationTitle() {
        navigationItem.largeTitleDisplayMode = .never
    }
    func setUI() {
        view.backgroundColor = .systemBackground
        title = "Detail News"
        detailImage.layer.cornerRadius = 0
    }
    func setAddSubviews() {
        view.addSubview(detailImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(sourceLabel)
        view.addSubview(customButton)
        view.addSubview(button)
    }
    func saveButtonConfigure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    func setTarget() {
        customButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    func setLayout() {
        detailImage.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 0), size: .init(width: view.frame.width, height: 275))
        detailImage.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 240).isActive = true
        
        titleLabel.anchor(top: detailImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10), size: .init(width: view.frame.width, height: 50))
        titleLabel.centerYAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: 40).isActive = true
        
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: view.frame.width, height: 130))
        descriptionLabel.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60).isActive = true
        
        sourceLabel.anchor(top: descriptionLabel.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: view.frame.width, height: 200))
        sourceLabel.centerYAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40).isActive = true
        
        customButton.anchor(top: sourceLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 15), size: .init(width: 50, height: 50))
        customButton.centerYAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 20).isActive = true
    }
}
