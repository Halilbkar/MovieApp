//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

protocol HomeViewDelegate {
    var presenter: HomePresenterDelegate? {get set}
}

final class HomeViewController: UIViewController, HomeViewDelegate {
    var presenter: HomePresenterDelegate?
    
    private lazy var previewUIView: PreviewUIView = {
        let view = PreviewUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var trendingUIView: TrendingUIView = {
        let view = TrendingUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor(red: 0.084, green: 0.078, blue: 0.121, alpha: 1).cgColor
        
        view.addSubview(previewUIView)
        view.addSubview(trendingUIView)
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
