//
//  TabBarInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation

protocol TabBarInteractorInputs {
    
}

protocol TabBarInteractorOutputs: AnyObject {
    
}

class TabBarInteractor {
    weak var presenter: TabBarInteractorOutputs?

}

extension TabBarInteractor: TabBarInteractorInputs {
    
}
