//
//  SearchCollectionViewCell.swift
//  MovieApp
//
//  Created by Halil Bakar on 29.08.2023.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "Movie"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 14))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var model: MoviesTitle?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    internal func showMoviesTitle(model: MoviesTitle?) {
        self.model = model
        label.text = model?.title ?? ""
    }
}
