//
//  PreviewUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

class PreviewUIView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "Movie"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 20))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    override init(frame: CGRect) {
        super .init(frame: frame)
                
        addSubview(label)
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 44)),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -137)),
        
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: CGFloat.dHeight(padding: 28)),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 191)),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 327))
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
