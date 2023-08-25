//
//  LoginRouter.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation
import UIKit.UIViewController

protocol LoginRouterProtocol {
    func toSignUp()
    func toHome()
}

class LoginRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startExecution() -> UIViewController {
        let view = LoginViewController()
        let router = LoginRouter(view: view)
        let intercator = LoginInteractor(authManager: AuthManager())
        let presenter = LoginPresenter(view: view, interactor: intercator, router: router)
        
        view.presenter = presenter
        intercator.presenter = presenter
        
        return view
    }
}

extension LoginRouter: LoginRouterProtocol {
    func toSignUp() {
//        let signUpModule = SignUpRouter.startSignUp()
//        view?.navigationController?.pushViewController(signUpModule, animated: true)
    }
    
    func toHome() {
        let tabBarModule = TabBarRouter.startExecution()
//        windowManager?.changeRootViewController(tabBarModule, animated: true)
        view?.navigationController?.pushViewController(tabBarModule, animated: true)
    }
}
