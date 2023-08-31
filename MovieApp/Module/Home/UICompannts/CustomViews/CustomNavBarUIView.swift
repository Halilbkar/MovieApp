//
//  CustomNavBarUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import UIKit

class CustomNavBarUIView: UIView {
    
    private lazy var profilePhotoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Halil"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Welcome,"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = UIColor(named: "background")
        
        addSubview(welcomeLabel)
        addSubview(userNameLabel)
        addSubview(profilePhotoImageView)
        
        addShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            welcomeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat.dHeight(padding: -12)),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            
            userNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat.dHeight(padding: -12)),
            userNameLabel.leadingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor, constant: CGFloat.dWidth(padding: 8)),
            
            profilePhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat.dHeight(padding: -8)),
            profilePhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -24)),
            profilePhotoImageView.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 36)),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 36))
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor.systemGray5.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 4
    }
    
    func showModel(model: CurrentUserModel) {
        welcomeLabel.text = "Welcome,"
        profilePhotoImageView.sd_setImage(with: URL(string: model.profileImageURLString ?? "https://picsum.photos/seed/picsum/500/500"))
        userNameLabel.text = model.name
    }
}
