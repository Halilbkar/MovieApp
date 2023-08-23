//
//  HomeInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol HomeInteractorDelegate {
    var presenter: HomePresenterDelegate? {get set}
}

class HomeInteractor: HomeInteractorDelegate {
    var presenter: HomePresenterDelegate?
    
}
