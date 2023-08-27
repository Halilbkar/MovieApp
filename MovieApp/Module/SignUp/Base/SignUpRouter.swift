//
//  SignUpRouter.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation
import UIKit.UIViewController

protocol SignUpRouterProtocol {
    func toLogin()
}

final class SignUpRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startExecution() -> UIViewController {
        let view = SignUpViewController()
        let interactor = SignUpInteractor(authManager: AuthManager())
        let router = SignUpRouter(view: view)
        let presenter = SignUpPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension SignUpRouter: SignUpRouterProtocol {
    func toLogin() {
        let _ = SignUpRouter.startExecution()
        view?.navigationController?.popViewController(animated: true)
    }
}
