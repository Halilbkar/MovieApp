//
//  HomeRouter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation
import UIKit.UIViewController

protocol HomeRouterProtocol {
    
}

final class HomeRouter {

    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startExecution() -> UIViewController {
        let view = HomeViewController()
        let router = HomeRouter(view: view)
        let intercator = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: intercator, router: router)
        
        view.presenter = presenter
        intercator.presenter = presenter
        
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    
}
