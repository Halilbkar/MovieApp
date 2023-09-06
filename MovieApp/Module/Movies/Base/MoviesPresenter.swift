//
//  MoviesPresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol MoviesPresenterInputs {
    func viewDidLoad()
    func viewWillAppear()
    func showMoviesTitle() -> [MoviesTitle]?
    func getData(isSelect: MoviesTitle?)
    func addFav(model: Results?)
    func isFav(model: Results?) -> Bool?
    func toDetail(movie: Results)
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
        view?.prepareMoviesUIView()
        interactor?.getCategoryData(category: .trending)
    }
    
    func viewWillAppear() {
        view?.setTabBarVisibility()
    }
    
    func showMoviesTitle() -> [MoviesTitle]? {
        interactor?.showMoviesTitle()
    }
    
    func getData(isSelect: MoviesTitle?) {
        switch isSelect {
        case .discover:
            interactor?.getCategoryData(category: .discover)
        case .popular:
            interactor?.getCategoryData(category: .popular)
        case .topRated:
            interactor?.getCategoryData(category: .topRated)
        case .trending:
            interactor?.getCategoryData(category: .trending)
        case .upComing:
            interactor?.getCategoryData(category: .upComing)
        default: break
        }
    }
    
    func isFav(model: Results?) -> Bool? {
        interactor?.isFav(model: model)
    }
    
    func addFav(model: Results?) {
        interactor?.addFav(model: model)
    }
    
    func toDetail(movie: Results) {
        router?.toDetail(movie: movie)
    }
}

extension MoviesPresenter: MoviesInteractorOutputs {
    func dataAndRefreshed(model: [Results]) {
        view?.dataAndRefreshed(model: model)
    }
}
