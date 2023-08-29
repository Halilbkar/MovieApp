//
//  MoviesUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 29.08.2023.
//

import UIKit

protocol MoviesUIViewProtocol: AnyObject {
    func showMovies() -> [Results]?
    func showMoviesTitle() -> [MoviesTitle]?
    func selectTitle(_ isSelect: MoviesTitle?)
}

class MoviesUIView: UIView {
    
    private lazy var moviesCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: CGFloat.dWidth(padding: 176), height: CGFloat.dHeight(padding: 240))
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var moviesTitleCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: CGFloat.dWidth(padding: 80), height: CGFloat.dHeight(padding: 32))
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
        
    weak var delegate: MoviesUIViewProtocol?
    
    private var isSelect: MoviesTitle? {
        didSet {
            delegate?.selectTitle(isSelect)
        }
    }

    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(moviesTitleCollectionView)
        addSubview(moviesCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            moviesTitleCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 4)),
            moviesTitleCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesTitleCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesTitleCollectionView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 32)),
        
            moviesCollectionView.topAnchor.constraint(equalTo: moviesTitleCollectionView.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            moviesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func reloadData() {
        moviesCollectionView.reloadData()
    }
}

extension MoviesUIView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == moviesTitleCollectionView {
            return delegate?.showMoviesTitle()?.count ?? 0
        }
        
        if collectionView == moviesCollectionView {
            return delegate?.showMovies()?.count ?? 0
        }
        
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == moviesTitleCollectionView {
            guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }

            let movieTitle = delegate?.showMoviesTitle()?[indexPath.row]
            movieCell.showMoviesTitle(model: movieTitle)
            
            return movieCell
        }
        
        if collectionView == moviesCollectionView {
            guard let titleCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
            
            titleCell.showModel(model: delegate?.showMovies()?[indexPath.row])
            
            return titleCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == moviesTitleCollectionView {
            isSelect = delegate?.showMoviesTitle()?[indexPath.row]
        }
    }
}
