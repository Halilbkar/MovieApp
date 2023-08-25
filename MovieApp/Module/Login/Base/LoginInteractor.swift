//
//  LoginInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation

protocol LoginInteractorInputs {
    
}

protocol LoginInteractorOutputs: AnyObject {
    
}

final class LoginInteractor {
    weak var presenter: LoginInteractorOutputs?
}

extension LoginInteractor: LoginInteractorInputs {

}
