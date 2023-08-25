//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol HomePresenterIntputs {
    func viewDidLoad()
}

final class HomePresenter {
    private weak var view: HomeViewProtocol?
    private let interactor: HomeInteractorInputs?
    private let router: HomeRouterProtocol?
    
    init(view: HomeViewProtocol, interactor: HomeInteractorInputs, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomePresenterIntputs {
    func viewDidLoad() {
        view?.setViewBackgroundColor(color: "background")
        view?.setProfileImageAndUserEmail()
        view?.randomMovies()
        view?.prepareTrendingUIView()
        view?.preparePreviewUIView()
        view?.prepareNavBarView()
        view?.dataRefreshed()
    }
}

extension HomePresenter: HomeInteractorOutputs {
    
}
