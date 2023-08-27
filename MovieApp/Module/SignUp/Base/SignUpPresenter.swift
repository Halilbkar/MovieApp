//
//  SignUpPresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation

protocol SignUpPresenterInputs {
    func viewDidLoad()
    func signUpButtonTapped(username: String, password: String, tryPass: String)
}

class SignUpPresenter {
    private weak var view: SignUpViewProtocol?
    private let interactor: SignUpInteractorInputs?
    private let router: SignUpRouterProtocol?
    
    init(view: SignUpViewProtocol, interactor: SignUpInteractorInputs, router: SignUpRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SignUpPresenter: SignUpPresenterInputs {

    func viewDidLoad() {
        view?.setViewBackgroundColor(color: .white)
        view?.prepareLoginUIView()
    }
    
    func signUpButtonTapped(username: String, password: String, tryPass: String) {
        guard !username.isEmpty, !password.isEmpty, !tryPass.isEmpty
        else {
            print(GeneralError.emailPasswordEmpty.localizedDescription)
            return
        }
        
        guard password == tryPass
        else {
            print(GeneralError.passwordsAreDifferent.localizedDescription)
            return
        }
        
        interactor?.signUpTapped(username: username, password: password)
    }
}

extension SignUpPresenter: SignUpInteractorOutputs {
    func signUpFailed(error: FirebaseError) {
        
    }
    
    func signUpSucceed() {
        router?.toLogin()
    }
}
