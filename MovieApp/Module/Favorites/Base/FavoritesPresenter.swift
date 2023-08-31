//
//  FavoritesPresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import Foundation

protocol FavoritesPresenterInputs {
    func viewDidLoad()
}

final class FavoritesPresenter {
    private weak var view: FavoritesViewProtocol?
    private let interactor: FavoritesInteractorInputs?
    private let router: FavoritesRouterProtocol?
    
    init(view: FavoritesViewProtocol, interactor: FavoritesInteractorInputs, router: FavoritesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterInputs {
    func viewDidLoad() {
        view?.prepareFavMoviesUIView()
        view?.setViewBackgroundColor(color: "background")
    }
}

extension FavoritesPresenter: FavoritesInteractorOutputs {
    
}
