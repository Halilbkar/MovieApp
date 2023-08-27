//
//  HomeInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol HomeInteractorInputs {
    
}

protocol HomeInteractorOutputs: AnyObject {
    
}

class HomeInteractor {
    weak var presenter: HomeInteractorOutputs?
    private let servie: MoviesServiceProtocol?
        
    init(servie: MoviesServiceProtocol?) {
        self.servie = servie
    }
}

extension HomeInteractor: HomeInteractorInputs {
    
}
