//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func setViewBackgroundColor(color: String)
    func prepareNavBarView()
    func preparePreviewUIView()
    func prepareTrendingUIView()
    func dataRefreshed()
    func showMoviesImage()
    func showProfileImageAndEmail(model: CurrentUserModel)
}

final class HomeViewController: UIViewController {
    
    private lazy var previewUIView: PreviewUIView = {
        let view = PreviewUIView()
        
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var trendingUIView: TrendingUIView = {
        let view = TrendingUIView()
        
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var customNavBarView: CustomNavBarUIView = {
        let view = CustomNavBarUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    internal var presenter: HomePresenterIntputs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            customNavBarView.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBarView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 90)),
            
            previewUIView.topAnchor.constraint(equalTo: customNavBarView.bottomAnchor),
            previewUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 300)),
            
            trendingUIView.topAnchor.constraint(equalTo: previewUIView.bottomAnchor),
            trendingUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trendingUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trendingUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 350)),
        ])
    }
}

// MARK: - HomeView Protocols
extension HomeViewController: HomeViewProtocol {
    func setViewBackgroundColor(color: String) {
        view.backgroundColor = UIColor(named: color)
    }
    
    func prepareNavBarView() {
        view.addSubview(customNavBarView)
    }
    
    func preparePreviewUIView() {
        view.addSubview(previewUIView)
    }
    
    func prepareTrendingUIView() {
        view.addSubview(trendingUIView)
    }
    
    func dataRefreshed() {
        trendingUIView.reloadData()
    }
    
    func showMoviesImage() {
        previewUIView.showMoviesImage()
    }
    
    func showProfileImageAndEmail(model: CurrentUserModel) {
        customNavBarView.showModel(model: model)
    }
}

// MARK: - TrendingUIView Protocol

extension HomeViewController: TrendingUIViewProtocol {
    func showMovies() -> [Results]? {
        presenter.showMovies()
    }
}

// MARK: - PreviewUIView Protocol

extension HomeViewController: PreviewUIViewProtocol {
    func showMoviesImage() -> Results? {
        presenter.showMoviesImage()
    }
}
