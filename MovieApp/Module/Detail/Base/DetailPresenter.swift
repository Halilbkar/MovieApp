//
//  DetailPresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 5.09.2023.
//

import Foundation

protocol DetailPresenterInputs {
    
}

class DetailPresenter {
    private weak var view: DetailViewControllerProtocol?
    private let interactor: DetailInteractorInputs?
    private let router: DetailRouterProtocol?
    
    init(view: DetailViewControllerProtocol, interactor: DetailInteractorInputs, router: DetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension DetailPresenter: DetailPresenterInputs {
    
}

extension DetailPresenter: DetailInteractorOutputs {
    
}
