//
//  MoviesRouter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation
import UIKit

protocol MoviesRouterProtocol {
    func toDetail(movie: Results)
}

class MoviesRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startExecution() -> UIViewController {
        let view = MoviesViewController()
        let router = MoviesRouter(view: view)
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension MoviesRouter: MoviesRouterProtocol {
    func toDetail(movie: Results) {
        let detailModule = DetailRouter.startExecution(movie: movie)
        view?.navigationController?.pushViewController(detailModule, animated: true)
        view?.tabBarController?.tabBar.isHidden = true
    }
}
