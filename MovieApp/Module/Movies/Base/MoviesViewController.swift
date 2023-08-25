//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

protocol MoviesViewProtocol: AnyObject {
    
}

final class MoviesViewController: UIViewController {
    
    internal var presenter: MoviesPresenterInputs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MoviesViewController: MoviesViewProtocol {
    
}
