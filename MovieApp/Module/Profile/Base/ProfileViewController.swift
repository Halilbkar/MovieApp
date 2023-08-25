//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
}

class ProfileViewController: UIViewController {
   
    internal var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ProfileViewController: ProfileViewProtocol {
    
}
