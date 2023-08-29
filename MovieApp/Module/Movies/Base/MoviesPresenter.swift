//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol MoviesPresenterInputs {
    func viewDidLoad()
    func showMovies() -> [Results]?
    func showMoviesTitle() -> [MoviesTitle]?
    func getData(isSelect: MoviesTitle?)
}

final class MoviesPresenter {
    private weak var view: MoviesViewProtocol?
    private let interactor: MoviesInteractorInputs?
    private let router: MoviesRouterProtocol?
    
    init(view: MoviesViewProtocol, interactor: MoviesInteractorInputs?, router: MoviesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MoviesPresenter: MoviesPresenterInputs {
    func viewDidLoad() {
        view?.setViewBackgroundColor(color: "background")
        view?.prepareSearchUIView()
        view?.prepareMoviesUIView()
        view?.dataRefreshed()
        interactor?.getTrendingData()
    }
    
    func showMovies() -> [Results]? {
        interactor?.showMovies()
    }
    
    func showMoviesTitle() -> [MoviesTitle]? {
        interactor?.showMoviesTitle()
    }
    
    func getData(isSelect: MoviesTitle?) {
        switch isSelect {
        case .discover:
            interactor?.getDiscoverData()
        case .popular:
            interactor?.getPopularData()
        case .topRated:
            interactor?.getTopRatedData()
        case .trending:
            interactor?.getTrendingData()
        case .upComing:
            interactor?.getUpComingData()
        default: break
        }
    }
}

extension MoviesPresenter: MoviesInteractorOutputs {
    func dataRefreshed() {
        view?.dataRefreshed()
    }
}
