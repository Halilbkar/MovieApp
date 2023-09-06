//
//  DetailRouter.swift
//  MovieApp
//
//  Created by Halil Bakar on 5.09.2023.
//

import Foundation
import UIKit.UIViewController

protocol DetailRouterProtocol {
    func toBack()
}

class DetailRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startExecution(movie: Results) -> UIViewController {
        let view = DetailViewController()
        let router = DetailRouter(view: view)
        let interactor = DetailInteractor(movie: movie)
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    func toBack() {
        view?.navigationController?.popViewController(animated: true)
    }
}
