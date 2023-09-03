//
//  SignUpViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation
import UIKit

protocol SignUpViewProtocol: AnyObject {
    func setViewBackgroundColor(color: UIColor)
    func prepareLoginUIView()
}

class SignUpViewController: UIViewController {
    
    private lazy var signUpUIView: SignUpUIView = {
        let view = SignUpUIView()
        
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    internal var presenter: SignUpPresenterInputs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    deinit {
        print("DEİNİT \(self.classForCoder)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
        
            signUpUIView.topAnchor.constraint(equalTo: view.topAnchor),
            signUpUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signUpUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 800))
        ])
    }
}

extension SignUpViewController: SignUpViewProtocol {
    func setViewBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
    
    func prepareLoginUIView() {
        view.addSubview(signUpUIView)
    }
}

extension SignUpViewController: SignUpUIViewProtocol {
    func signUpTapped(_ name: String, _ username: String, _ password: String, _ tryPass: String) {
        presenter.signUpButtonTapped(username: username, password: password, tryPass: tryPass)
    }
}
