//
//  TabBarRouter.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation
import UIKit.UIViewController

protocol TabBarRouterProtocol {
    
}

class TabBarRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startExecution() -> UIViewController {
        let view = TabBarController()
        let interactor = TabBarInteractor()
        let router = TabBarRouter(view: view)
        let presenter = TabBarPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
}

extension TabBarRouter: TabBarRouterProtocol {
    
}
