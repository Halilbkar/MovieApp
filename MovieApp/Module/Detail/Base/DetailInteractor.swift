//
//  DetailInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 5.09.2023.
//

import Foundation

protocol DetailInteractorInputs {
    
}

protocol DetailInteractorOutputs: AnyObject {
}

class DetailInteractor {
    weak var presenter: DetailInteractorOutputs?
}

extension DetailInteractor: DetailInteractorInputs {
    
}
