//
//  ProfileRouter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation
import UIKit.UIViewController

protocol ProfileRouterProtocol {
    
}

class ProfileRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startExecution() -> UIViewController {
        let view = ProfileViewController()
        let router = ProfileRouter(view: view)
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension ProfileRouter: ProfileRouterProtocol {
    
}

