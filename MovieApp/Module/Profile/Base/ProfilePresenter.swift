//
//  ProfilePresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol ProfilePresenterProtocol {

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
    
}

extension ProfilePresenter: ProfileInteractorOutputs {
    
}

