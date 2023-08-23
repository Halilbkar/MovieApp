//
//  MoviesRouter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol MoviesRouterDelegate {
    static func startExecution() -> MoviesRouterDelegate

}

class MoviesRouter: MoviesRouterDelegate {
    static func startExecution() -> MoviesRouterDelegate {
        
        let router = MoviesRouter()
        
        var view: MoviesViewDelegate = MoviesViewController()
        var presenter: MoviesPresenterDelegate = MoviesPresenter()
        var interactor: MoviesInteractorDelegate = MoviesInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return router
    }
}
