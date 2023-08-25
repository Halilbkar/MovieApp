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
    
}

extension HomeInteractor: HomeInteractorInputs {
    
}
