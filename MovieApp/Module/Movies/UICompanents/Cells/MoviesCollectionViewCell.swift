//
//  MoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by Halil Bakar on 29.08.2023.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
    
    private var model: Results?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    internal func showModel(model: Results?) {
        self.model = model
        imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(model?.poster_path ?? "")"))
    }
}
