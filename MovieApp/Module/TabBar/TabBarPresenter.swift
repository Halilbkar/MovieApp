//
//  TabBarPresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation

protocol TabBarPresenterInputs {
    func viewWillAppear()
}

class TabBarPresenter {
    private weak var view: TabBarControllerProtocol?
    private let interactor: TabBarInteractorInputs?
    private let router: TabBarRouterProtocol?
    
    init(view: TabBarControllerProtocol, interactor: TabBarInteractorInputs, router: TabBarRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension TabBarPresenter: TabBarPresenterInputs {
    func viewWillAppear() {
        view?.configureTabBar()
        view?.setTabBarControllers()
        view?.configureNavBar()
    }
}

extension TabBarPresenter: TabBarInteractorOutputs {
    
}
