//
//  LoginUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import UIKit

protocol LoginUIViewProtocol: AnyObject {
    func loginTapped(_ username: String, _ password: String)
    func signUpTapped()
}

class LoginUIView: UIView {
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Login"
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 20))
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Username"
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 12))
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Password"
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 12))
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.setPlaceholder(text: "Type your username", fontSize: 10, color: .systemGray4)
        textField.addBottomLine(color: .systemGray4, height: 1)
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.setPlaceholder(text: "Type your password", fontSize: 10, color: .systemGray4)
        textField.addBottomLine(color: .systemGray4, height: 1)

        return textField
    }()
    
    private lazy var forgotPassButton: UIButton = {
        var config = UIButton.Configuration.plain()
        
        config.title = "Forgot Password ?"
        config.baseForegroundColor = .black
        config.buttonSize = .mini
        
        let button = UIButton(configuration: config)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        
        config.cornerStyle = .capsule
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .black
        config.title = "LOGIN"
        config.buttonSize = .medium
        
        let button = UIButton(configuration: config)
        
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Or Sign Up Using"
        label.font = .systemFont(ofSize: CGFloat.dWidth(padding: 10))
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        var config = UIButton.Configuration.plain()
        
        config.cornerStyle = .capsule
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .white
        config.title = "SIGN UP"
        config.buttonSize = .small
        
        let button = UIButton(configuration: config)
        
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: LoginUIViewProtocol?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(loginLabel)
        addSubview(usernameLabel)
        addSubview(usernameTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(forgotPassButton)
        addSubview(loginButton)
        addSubview(signUpLabel)
        addSubview(signUpButton)
        
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - Actions
extension LoginUIView {
    @objc func loginTapped() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {return}
        delegate?.loginTapped(username, password)
    }
    
    @objc func signUpTapped() {
        delegate?.signUpTapped()
    }
}

// MARK: - Configure Layout
extension LoginUIView {
    func configureLayout() {
        NSLayoutConstraint.activate([
            
            loginLabel.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 64)),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 24)),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 4)),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -24)),
            
            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: CGFloat.dHeight(padding: 12)),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 4)),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -24)),
            
            forgotPassButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: CGFloat.dHeight(padding: 16)),
            forgotPassButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -8)),
            
            loginButton.topAnchor.constraint(equalTo: forgotPassButton.bottomAnchor, constant: CGFloat.dHeight(padding: 48)),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            signUpLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: CGFloat.dHeight(padding: 24)),
            signUpLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            signUpButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat.dHeight(padding: -16)),
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}