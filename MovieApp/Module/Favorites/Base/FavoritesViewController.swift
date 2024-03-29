//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func setViewBackgroundColor(color: String)
    func prepareFavMoviesUIView()
    func favMoviesData(model: [FavoritesMoviesModel])
}

final class FavoritesViewController: UIViewController {
    
    private lazy var favMoviesUIView: FavoritesMoviesUIView = {
        let view = FavoritesMoviesUIView()
        
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    internal var presenter: FavoritesPresenterInputs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    deinit {
        print("DEİNİT \(self.classForCoder)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
        
            favMoviesUIView.topAnchor.constraint(equalTo: view.topAnchor),
            favMoviesUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favMoviesUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favMoviesUIView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoritesViewController: FavoritesViewProtocol {
    func setViewBackgroundColor(color: String) {
        view.backgroundColor = UIColor(named: color)
    }
    
    func prepareFavMoviesUIView() {
        view.addSubview(favMoviesUIView)
    }
    
    func favMoviesData(model: [FavoritesMoviesModel]) {
        favMoviesUIView.favMoviesData(model: model)
    }
}

extension FavoritesViewController: FavoritesMoviesUIViewProtocol {
    func deleteFavMovie(movie: FavoritesMoviesModel) {
        presenter.deleteFavMovie(movie: movie)
    }
    
    func deleteAll() {
        presenter.deleteAll()
    }
}
