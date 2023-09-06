//
//  DetailPresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 5.09.2023.
//

import Foundation

protocol DetailPresenterInputs {
    func viewDidLoad()
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
    func viewDidLoad() {
        view?.prepareDetailUIView()
        view?.setTabBarVisibility()
        view?.setViewBackgroundColor(color: "background")
        interactor?.getTrailer()
    }
}

extension DetailPresenter: DetailInteractorOutputs {
    func trailerModel(model: MovieAndTrailerModel) {
        view?.trailerModel(model: model)
    }
}
