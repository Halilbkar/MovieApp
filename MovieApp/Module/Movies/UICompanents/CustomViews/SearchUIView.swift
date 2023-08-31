//
//  SearchUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 29.08.2023.
//

import UIKit

class SearchUIView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "Find Movies or watch more movies"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 20))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.placeholder = "Search"
        searchBar.layer.cornerRadius = 16
        searchBar.clipsToBounds = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(label)
        addSubview(searchBar)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 60)),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -24)),
            
            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: CGFloat.dHeight(padding: 28)),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 36)),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -24)),
            searchBar.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 30)),
            
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

