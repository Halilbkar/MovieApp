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
    func prepareTrendingUIView()
    func dataAndRefreshed(model: [Results])
    func showProfileImageAndEmail(model: CurrentUserModel)
    func showImageItems(model: [SelectedImageModelRealm]?)
}

final class HomeViewController: UIViewController {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    deinit {
        print("DEİNİT \(self.classForCoder)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            customNavBarView.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBarView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 90)),
            
            trendingUIView.topAnchor.constraint(equalTo: customNavBarView.bottomAnchor),
            trendingUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trendingUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trendingUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 650)),
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
    
    func prepareTrendingUIView() {
        view.addSubview(trendingUIView)
    }
    
    func dataAndRefreshed(model: [Results]) {
        trendingUIView.dataAndRefreshed(model: model)
    }
    
    func showProfileImageAndEmail(model: CurrentUserModel) {
        customNavBarView.showModel(model: model)
    }
    
    func showImageItems(model: [SelectedImageModelRealm]?) {
        customNavBarView.showProfileImage(model: model)
    }
}

// MARK: - TrendingUIView Protocol

extension HomeViewController: TrendingUIViewProtocol {
    
}
