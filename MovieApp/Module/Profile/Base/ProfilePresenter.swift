//
//  ProfilePresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol ProfilePresenterProtocol {
    func viewDidLoad()
    func showItems() -> [ProfileRowItemModel]?
    func signOutTapped()
}

class ProfilePresenter {
    private weak var view: ProfileViewProtocol?
    private let interactor: ProfileInteractorInputs?
    private let router: ProfileRouterProtocol?
    
    init(view: ProfileViewProtocol, interactor: ProfileInteractorInputs, router: ProfileRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func viewDidLoad() {
        view?.setBackgroundColor(color: "background")
        view?.prepareUserInfoView()
        view?.prepareProfileItemView()
        interactor?.getuserInfo()
    }
    
    func showItems() -> [ProfileRowItemModel]? {
        interactor?.showItems()
    }
    
    func signOutTapped() {
        interactor?.signOut()
    }
}

extension ProfilePresenter: ProfileInteractorOutputs {
    func showUserInfo(model: CurrentUserModel?) {
        view?.showUserInfo(model: model)
    }
    
    func signOutCompleted() {
        router?.toLogin()
    }
}

