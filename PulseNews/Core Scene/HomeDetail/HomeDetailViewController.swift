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
}
//MARK: - HomeDetailView Interface
extension HomeDetailViewController: HomeDetailViewInterface {
    func setHandleOutput(_ output: HomeDetailOutput) {
        switch output {
        case .load(let presentation):
            if let imageURL = presentation.urlToImage {
                detailImage.sd_imageIndicator = SDWebImageActivityIndicator.medium
                detailImage.sd_imageTransition = .fade
                detailImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: "photo"))
                titleLabel.text = presentation.title
                descriptionLabel.text = presentation.newsDescription
                sourceLabel.text = presentation.sourceName
            }
        case .showMorePage(let url):
            guard let url = URL(string: url) else { return }

            let configuration = SFSafariViewController.Configuration()
            configuration.entersReaderIfAvailable = true
    
            let vc = SFSafariViewController(url: url, configuration: configuration)
            vc.preferredControlTintColor = .label
            present(vc, animated: true)
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
    }
    func setTarget() {
        customButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    func setLayout() {
        detailImage.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 0), size: .init(width: view.frame.width, height: 250))
        detailImage.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 230).isActive = true
        
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
