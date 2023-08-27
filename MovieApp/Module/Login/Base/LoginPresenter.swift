//
//  LoginPresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation

protocol LoginPresenterInputs {
    func viewDidLoad()
    func loginButtonTapped(username: String, password: String)
    func forgotPassTapped(username: String)
    func signUpButtonTapped()
}

class LoginPresenter {
    private weak var view: LoginViewProtocol?
    private let interactor: LoginInteractorInputs?
    private let router: LoginRouterProtocol?
    
    init(view: LoginViewProtocol, interactor: LoginInteractorInputs, router: LoginRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension LoginPresenter: LoginPresenterInputs {
    func viewDidLoad() {
        view?.setViewBackgroundColor(color: .white)
        view?.prepareLoginUIView()
    }
    
    func loginButtonTapped(username: String, password: String) {
        guard !username.isEmpty,
              !password.isEmpty
        else {
            print(GeneralError.emailPasswordEmpty.localizedDescription)
            return
        }
        
        interactor?.login(username: username, password: password)
    }
    
    func forgotPassTapped(username: String) {
        interactor?.forgotPassword(username: username)
    }
    
    func signUpButtonTapped() {
        router?.toSignUp()
    }
}

extension LoginPresenter: LoginInteractorOutputs {
    func loginFailed(error: FirebaseError) {
        
    }
    
    func loginSucceed() {
        router?.toHome()
    }
    
    func forgotPasswordSucceed() {
        
    }
    
    func forgotPasswordFailed(error: FirebaseError) {
        
    }
}
