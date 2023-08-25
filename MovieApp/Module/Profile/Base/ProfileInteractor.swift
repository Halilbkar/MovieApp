//
//  ProfileInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol ProfileInteractorInputs {
   
}

protocol ProfileInteractorOutputs: AnyObject {
    
}

class ProfileInteractor  {
    var presenter: ProfileInteractorOutputs?

}

extension ProfileInteractor: ProfileInteractorInputs {
    
}
