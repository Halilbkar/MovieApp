//
//  ProfileRouter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation
import UIKit.UIViewController

protocol ProfileRouterProtocol {
    func toLogin()
    func toImagePicker(imagePicker: UIImagePickerController)
}

class ProfileRouter {
    
    private weak var view: UIViewController?
    private let windowManager: RootWindowManagerProtocol?

    init(view: UIViewController, windowManager: RootWindowManagerProtocol) {
        self.view = view
        self.windowManager = windowManager
    }
    
    static func startExecution() -> UIViewController {
        let view = ProfileViewController()
        let router = ProfileRouter(view: view, windowManager: RootWindowManager.shared)
        let interactor = ProfileInteractor(userInfoManager: UserInfoManager(), authManager: AuthManager(), storageManager: RealmManager())
        let presenter = ProfilePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension ProfileRouter: ProfileRouterProtocol {
    func toLogin() {
        let loginModule = UINavigationController(rootViewController: LoginRouter.startExecution())
        windowManager?.changeRootViewController(loginModule, animated: true)
    }
    
    func toImagePicker(imagePicker: UIImagePickerController) {
        view?.present(imagePicker, animated: true)
    }
}

