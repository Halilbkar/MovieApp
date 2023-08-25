//
//  MoviewInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol MoviesInteractorInputs {
    
}

protocol MoviesInteractorOutputs: AnyObject {
    
}

final class MoviesInteractor {
    var presenter: MoviesInteractorOutputs?
    
}

extension MoviesInteractor: MoviesInteractorInputs {
    
}
