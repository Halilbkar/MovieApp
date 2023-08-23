//
//  HomeRouter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation
import UIKit

//typealias EntryPoint = HomeViewDelegate & UIViewController

protocol HomeRouterDelegate {
//    var entry: EntryPoint? {get}
    
    static func startExecution() -> HomeRouterDelegate
}

class HomeRouter: HomeRouterDelegate {
//    var entry: EntryPoint?
    
    static func startExecution() -> HomeRouterDelegate {
        
        let router = HomeRouter()
        
        var view: HomeViewDelegate = HomeViewController()
        var presenter: HomePresenterDelegate = HomePresenter()
        var interactor: HomeInteractorDelegate = HomeInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
//        router.entry = view as? EntryPoint
        
        return router
    }
}
