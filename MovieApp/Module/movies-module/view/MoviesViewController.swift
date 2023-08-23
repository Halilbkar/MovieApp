//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation
import UIKit

protocol MoviesViewDelegate {
    var presenter: MoviesPresenterDelegate? {get set}
}

class MoviesViewController: UIViewController, MoviesViewDelegate {
    var presenter: MoviesPresenterDelegate?
    
}
