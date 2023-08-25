//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation
import UIKit

protocol LoginViewProtocol: AnyObject {
    func setViewBackgroundColor(color: UIColor)
    func prepareLoginUIView()
}

class LoginViewController: UIViewController {
    
    private lazy var loginUIView: LoginUIView = {
        let view = LoginUIView()
        
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    internal var presenter: LoginPresenterInputs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
        
            loginUIView.topAnchor.constraint(equalTo: view.topAnchor),
            loginUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 800))
        ])
    }
}

extension LoginViewController: LoginViewProtocol {
    func setViewBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
    
    func prepareLoginUIView() {
        view.addSubview(loginUIView)

    }
}

// MARK: - LoginUIViewProtocol - Actions
extension LoginViewController: LoginUIViewProtocol {
    func loginTapped(_ username: String, _ password: String) {
        
    }
    
    func signUpTapped() {
        
    }
}
