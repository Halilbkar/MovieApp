//
//  UserInfoUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import UIKit
import SDWebImage

class UserInfoUIView: UIView {
    
    private lazy var backView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "background")
        view.layer.cornerRadius = 50
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "Test"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 60
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(backView)
        addSubview(label)
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 55)),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
        
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 150)),
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 90)),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 120)),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 120))
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

    func showModel(model: CurrentUserModel?) {
        label.text = model?.userEmail ?? ""
        imageView.sd_setImage(with: URL(string: model?.profileImageURLString ?? ""))
    }
}
