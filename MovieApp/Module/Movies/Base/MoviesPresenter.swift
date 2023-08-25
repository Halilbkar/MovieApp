//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol MoviesPresenterInputs {
    
}

final class MoviesPresenter {
    private weak var view: MoviesViewProtocol?
    private let interactor: MoviesInteractorInputs?
    private let router: MoviesRouterProtocol?
    
    init(view: MoviesViewProtocol, interactor: MoviesInteractorInputs?, router: MoviesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension MoviesPresenter: MoviesPresenterInputs {
    
}

extension MoviesPresenter: MoviesInteractorOutputs {
    
}
