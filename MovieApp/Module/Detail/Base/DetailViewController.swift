//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 5.09.2023.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func prepareDetailUIView()
    func setViewBackgroundColor(color: String)
    func setTabBarVisibility()
    func trailerModel(model: MovieAndTrailerModel)
}

class DetailViewController: UIViewController {
    
    private lazy var detailUIView: DetailUIView = {
        let view = DetailUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    internal var presenter: DetailPresenterInputs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            detailUIView.topAnchor.constraint(equalTo: view.topAnchor),
            detailUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 800)),
        ])
    }
    
    deinit {
        print("DEİNİT \(self.classForCoder)")
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func prepareDetailUIView() {
        view.addSubview(detailUIView)
    }
    
    func setViewBackgroundColor(color: String) {
        view.backgroundColor = UIColor(named: color)
    }
    
    func setTabBarVisibility() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func trailerModel(model: MovieAndTrailerModel) {
        detailUIView.trailerModel(model: model)
    }
}
