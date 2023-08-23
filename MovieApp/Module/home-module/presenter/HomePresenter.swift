//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol HomePresenterDelegate {
    var router: HomeRouterDelegate? {get set}
    var view: HomeViewDelegate? {get set}
    var interactor: HomeInteractorDelegate? {get set}
}

class HomePresenter: HomePresenterDelegate {
    var router: HomeRouterDelegate?
    
    var view: HomeViewDelegate?
    
    var interactor: HomeInteractorDelegate?
}
