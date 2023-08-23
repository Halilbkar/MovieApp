//
//  MoviewInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol MoviesInteractorDelegate {
    var presenter: MoviesPresenterDelegate? {get set}
}

class MoviesInteractor: MoviesInteractorDelegate {
    var presenter: MoviesPresenterDelegate?
    
    
}
