//
//  ProfileItemUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import UIKit

protocol ProfileItemUIViewProtocol: AnyObject {
    func showItems() -> [ProfileRowItemModel]?
    func signOutTapped()
}

class ProfileItemUIView: UIView {
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(ProfileItemTableViewCell.self, forCellReuseIdentifier: ProfileItemTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var signOutButton: UIButton = {
        var config = UIButton.Configuration.filled()
        
        config.cornerStyle = .capsule
        config.title = "Logout"
        config.attributedTitle?.font = .boldSystemFont(ofSize: 12)
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .black
        config.buttonSize = .large
        
        let button = UIButton(configuration: config)
        
        button.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    weak var delegate: ProfileItemUIViewProtocol?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileTableView)
        addSubview(signOutButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
        
            profileTableView.topAnchor.constraint(equalTo: topAnchor),
            profileTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileTableView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 200)),
            
            signOutButton.topAnchor.constraint(equalTo: profileTableView.bottomAnchor, constant: CGFloat.dHeight(padding: 50)),
            signOutButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - SignOutButton Actions

extension ProfileItemUIView {
    @objc private func signOutTapped() {
        delegate?.signOutTapped()
    }
}

// MARK: - TableView Protocols

extension ProfileItemUIView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.showItems()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileItemTableViewCell.identifier, for: indexPath) as? ProfileItemTableViewCell else { return UITableViewCell() }
        
        cell.showModel(model: delegate?.showItems()?[indexPath.row])
        
        return cell
    }
}
