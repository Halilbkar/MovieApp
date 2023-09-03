//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

protocol MoviesViewProtocol: AnyObject {
    func setViewBackgroundColor(color: String)
    func prepareMoviesUIView()
    func dataRefreshed(movies: [Results])
}

final class MoviesViewController: UIViewController {
    
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
            moviesUIView.topAnchor.constraint(equalTo: view.topAnchor),
            moviesUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 800)),
        ])
    }
}

extension MoviesViewController: MoviesViewProtocol {
    func setViewBackgroundColor(color: String) {
        view.backgroundColor = UIColor(named: color)
    }
    
    func prepareMoviesUIView() {
        view.addSubview(moviesUIView)
    }
    
    func dataRefreshed(movies: [Results]) {
        moviesUIView.setMovies(movies: movies)
    }
}

extension MoviesViewController: MoviesUIViewProtocol {
    func addFavorites(model: Results?) {
        presenter.addFav(model: model)
    }
    
    func isFav(model: Results?) -> Bool? {
        presenter.isFav(model: model)
    }

    func showMoviesTitle() -> [MoviesTitle]? {
        presenter.showMoviesTitle()
    }
    
    func selectTitle(_ isSelect: MoviesTitle?) {
        presenter.getData(isSelect: isSelect)
    }
}
