//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol MoviesPresenterDelegate {
    var view: MoviesViewDelegate? {get set}
    var interactor: MoviesInteractorDelegate? {get set}
    var router: MoviesRouterDelegate? {get set}

}

class MoviesPresenter: MoviesPresenterDelegate {
    var view: MoviesViewDelegate?
    
    var interactor: MoviesInteractorDelegate?
    
    var router: MoviesRouterDelegate?
    
    
}
