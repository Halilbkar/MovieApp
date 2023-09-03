//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol HomePresenterIntputs {
    func viewDidLoad()
    func viewWillAppear()
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
        view?.prepareTrendingUIView()
        view?.prepareNavBarView()
        interactor?.getData()
        interactor?.getUserProfilePictureAndEmail()
        interactor?.getProfileImage()
    }
    
    func viewWillAppear() {
        interactor?.getProfileImage()
    }
}

extension HomePresenter: HomeInteractorOutputs {
    func dataAndRefreshed(model: [Results]) {
        view?.dataAndRefreshed(model: model)
    }
    
    func showProfileImageAndEmail(model: CurrentUserModel) {
        view?.showProfileImageAndEmail(model: model)
    }
    
    func showImageItems(model: [SelectedImageModelRealm]) {
        view?.showImageItems(model: model)
    }
}
