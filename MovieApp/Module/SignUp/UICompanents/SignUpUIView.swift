//
//  SignUpUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import UIKit

protocol SignUpUIViewProtocol: AnyObject {
    func signUpTapped(_ name: String,_ username: String,_ password: String,_ tryPass: String)
}

class SignUpUIView: UIView {
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Sign Up"
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 24))
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.font = .systemFont(ofSize: CGFloat.dWidth(padding: 12))
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Username"
        label.font = .systemFont(ofSize: CGFloat.dWidth(padding: 12))
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Password"
        label.font = .systemFont(ofSize: CGFloat.dWidth(padding: 12))
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.setPlaceholder(text: "Type your name", fontSize: 10, color: .systemGray4)
        textField.addBottomLine(color: .systemGray4, height: 1)
        
        return textField
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
    
    private lazy var tryPasswordTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.setPlaceholder(text: "Type your try password", fontSize: 10, color: .systemGray4)
        textField.addBottomLine(color: .systemGray4, height: 1)

        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        var config = UIButton.Configuration.filled()
        
        config.cornerStyle = .capsule
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .black
        config.title = "SIGN UP"
        config.attributedTitle?.font = .boldSystemFont(ofSize: 16)
        config.buttonSize = .medium
        
        let button = UIButton(configuration: config)
        
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: SignUpUIViewProtocol?

    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(signUpLabel)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(passwordLabel)
        addSubview(usernameTextField)
        addSubview(nameTextField)
        addSubview(passwordTextField)
        addSubview(tryPasswordTextField)
        addSubview(signUpButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Actions

extension SignUpUIView {
    @objc private func signUpTapped() {
        guard let name = nameTextField.text, let username = usernameTextField.text,
              let password = passwordTextField.text, let tryPass = tryPasswordTextField.text else { return }
        
        delegate?.signUpTapped(name, username, password, tryPass)
    }
}

// MARK: - Configure Layout

extension SignUpUIView {
    func configureLayout() {
        NSLayoutConstraint.activate([
            
            signUpLabel.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 80)),
            signUpLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 48)),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 8)),
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 340)),
            nameTextField.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 20)),
            
            usernameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: CGFloat.dHeight(padding: 16)),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 8)),
            usernameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 340)),
            usernameTextField.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 20)),
            
            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: CGFloat.dHeight(padding: 16)),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 8)),
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 340)),
            passwordTextField.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 20)),
            
            tryPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: CGFloat.dHeight(padding: 12)),
            tryPasswordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            tryPasswordTextField.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 340)),
            tryPasswordTextField.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 20)),
            
            signUpButton.topAnchor.constraint(equalTo: tryPasswordTextField.bottomAnchor, constant: CGFloat.dHeight(padding: 48)),
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 340)),
        ])
    }
}
