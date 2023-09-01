//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

protocol MoviesViewProtocol: AnyObject {
    func setViewBackgroundColor(color: String)
    func prepareSearchUIView()
    func prepareMoviesUIView()
    func dataRefreshed()
}

final class MoviesViewController: UIViewController {
    
    private lazy var searchUIView: SearchUIView = {
        let view = SearchUIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var moviesUIView: MoviesUIView = {
        let view = MoviesUIView()
        
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    internal var presenter: MoviesPresenterInputs!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            
            searchUIView.topAnchor.constraint(equalTo: view.topAnchor),
            searchUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 160)),
            
            moviesUIView.topAnchor.constraint(equalTo: searchUIView.bottomAnchor),
            moviesUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 600)),
        ])
    }
}

extension MoviesViewController: MoviesViewProtocol {
    func setViewBackgroundColor(color: String) {
        view.backgroundColor = UIColor(named: color)
    }
    
    func prepareSearchUIView() {
        view.addSubview(searchUIView)
    }
    
    func prepareMoviesUIView() {
        view.addSubview(moviesUIView)
    }
    
    func dataRefreshed() {
        moviesUIView.reloadData()
    }
}

extension MoviesViewController: MoviesUIViewProtocol {
    func addFavorites(model: Results?) {
        presenter.addFav(model: model)
    }
    
    func isFav(model: Results?) -> Bool? {
        presenter.isFav(model: model)
    }
    
    func showMovies() -> [Results]? {
        presenter.showMovies()
    }

    func showMoviesTitle() -> [MoviesTitle]? {
        presenter.showMoviesTitle()
    }
    
    func selectTitle(_ isSelect: MoviesTitle?) {
        presenter.getData(isSelect: isSelect)
    }
}
