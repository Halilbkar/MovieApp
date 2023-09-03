//
//  SignUpInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation

protocol SignUpInteractorInputs {
    func signUpTapped(username: String, password: String)
}

protocol SignUpInteractorOutputs: AnyObject {
    func signUpFailed(error: FirebaseError)
    func signUpSucceed()
}

final class SignUpInteractor {
    weak var presenter: SignUpInteractorOutputs?
}

extension SignUpInteractor: SignUpInteractorInputs {
    func signUpTapped(username: String, password: String) {
        AuthManager.shared.signUp(email: username, password: password, completion: { [weak self] results in
            guard let self else { return }
            
            switch results {
            case .success(_):
                presenter?.signUpSucceed()
            case . failure(let error):
                presenter?.signUpFailed(error: error)
                print(error.localizedDescription)
            }
        })
    }
}
