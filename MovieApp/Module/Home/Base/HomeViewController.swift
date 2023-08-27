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
    func randomMovies()
    func dataRefreshed()
    func setProfileImageAndUserEmail()
}

final class HomeViewController: UIViewController {
    
    private lazy var previewUIView: PreviewUIView = {
        let view = PreviewUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var trendingUIView: TrendingUIView = {
        let view = TrendingUIView()
        
        view.delegate = self
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
            
            previewUIView.topAnchor.constraint(equalTo: view.topAnchor),
            previewUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previewUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            previewUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 328)),
            
            trendingUIView.topAnchor.constraint(equalTo: previewUIView.bottomAnchor),
            trendingUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trendingUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trendingUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 385)),
        ])
    }
}

// MARK: - HomeView Protocols
extension HomeViewController: HomeViewProtocol {
    func setViewBackgroundColor(color: String) {
        view.backgroundColor = UIColor(named: color)
    }
    
    func prepareNavBarView() {
        
    }
    
    func preparePreviewUIView() {
        view.addSubview(previewUIView)
    }
    
    func prepareTrendingUIView() {
        view.addSubview(trendingUIView)
    }
    
    func randomMovies() {
        
    }
    
    func dataRefreshed() {
        trendingUIView.reloadData()
    }
    
    func setProfileImageAndUserEmail() {
        
    }
}

// MARK: - TrendingUIView Protocol

extension HomeViewController: TrendingUIViewProtocol {
    func showMovies() -> [Results]? {
        presenter.showMovies()
    }
}
