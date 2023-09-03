//
//  LoginInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation

protocol LoginInteractorInputs {
    func login(username: String, password: String)
    func forgotPassword(username: String)
    func googleSingIn()
}

protocol LoginInteractorOutputs: AnyObject {
    func loginFailed(error: FirebaseError)
    func loginSucceed()
    func forgotPasswordSucceed()
    func forgotPasswordFailed(error: FirebaseError)
}

final class LoginInteractor {
    weak var presenter: LoginInteractorOutputs?
}

extension LoginInteractor: LoginInteractorInputs {
    func login(username: String, password: String) {
        AuthManager.shared.login(email: username, password: password, completion: { [weak self] results in
            guard let self else { return }
            
            switch results {
            case .success(_):
                presenter?.loginSucceed()
            case .failure(let error):
                presenter?.loginFailed(error: error)
                print(error.localizedDescription)
            }
        })
    }
    
    func forgotPassword(username: String) {
        AuthManager.shared.resetPassword(with: username, completion: { [weak self] results in
            guard let self else { return }
            
            switch results {
            case .success(_):
                presenter?.forgotPasswordSucceed()
            case .failure(let error):
                presenter?.forgotPasswordFailed(error: error)
            }
        })
    }
    
    func googleSingIn() {
        AuthManager.shared.signInWithGoogle(completion: { [weak self] results in
            guard let self else { return }
            
            switch results {
            case .success(_):
                presenter?.loginSucceed()
            case .failure(let error):
                presenter?.loginFailed(error: error)
            }
        })
    }
}
