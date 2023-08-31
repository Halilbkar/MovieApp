//
//  FavoritesInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import Foundation

protocol FavoritesInteractorInputs {
    
}

protocol FavoritesInteractorOutputs: AnyObject {

}

final class FavoritesInteractor {
    weak var presenter: FavoritesInteractorOutputs?
}

extension FavoritesInteractor: FavoritesInteractorInputs {
    
}
