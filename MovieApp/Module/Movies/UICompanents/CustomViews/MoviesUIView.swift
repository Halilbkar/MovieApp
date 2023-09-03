//
//  MoviesUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 29.08.2023.
//

import UIKit

protocol MoviesUIViewProtocol: AnyObject {
    func showMoviesTitle() -> [MoviesTitle]?
    func selectTitle(_ isSelect: MoviesTitle?)
    func addFavorites(model: Results?)
    func isFav(model: Results?) -> Bool?
}

class MoviesUIView: UIView {
    
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
        
        searchBar.delegate = self
        
        return searchBar
    }()
    
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
    
    private var model: [Results] = []
    private var filteredMovies: [Results] = []
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(label)
        addSubview(searchBar)
        addSubview(moviesTitleCollectionView)
        addSubview(moviesCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 60)),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -24)),
            
            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: CGFloat.dHeight(padding: 24)),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 36)),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -24)),
            searchBar.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 36)),
            
            moviesTitleCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: CGFloat.dHeight(padding: 12)),
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
    
    public func dataAndRefreshed(model: [Results]) {
        self.model = model
        self.filteredMovies = model
        moviesCollectionView.reloadData()
    }
}

extension MoviesUIView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == moviesTitleCollectionView {
            return delegate?.showMoviesTitle()?.count ?? 0
        }
        
        if collectionView == moviesCollectionView {
            return model.count
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
            
            titleCell.showModel(model: model[indexPath.row])
            
            return titleCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == moviesTitleCollectionView {
            isSelect = delegate?.showMoviesTitle()?[indexPath.row]
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let selectMovie = model[indexPath.row]
        var actionTitle = ""
        
        if !(delegate?.isFav(model: selectMovie))! {
            actionTitle = "Add to Favorites"
        } else {
            actionTitle = "Remove from Favorites"
        }
        
        let addFavoriteAction = UIAction(title: actionTitle) { [weak self] _ in
            guard let self else { return }
            self.delegate?.addFavorites(model: selectMovie)
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "", options: .displayInline, children: [addFavoriteAction])
        }
    }
}

extension MoviesUIView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            model = filteredMovies
        } else {
            model = filteredMovies
            self.model = model.filter({ movies in
                movies.original_title.lowercased().contains(searchText.lowercased())
            })
        }
        moviesCollectionView.reloadData()
    }
}
