//
//  TrendingUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

protocol TrendingUIViewProtocol: AnyObject {
    
}

class TrendingUIView: UIView {
    
    private lazy var randomMoviesLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Editor's choice"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 20))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var imageViewOne: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var imageViewTwo: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var trendingMovieslabel: UILabel = {
        let label = UILabel()
        
        label.text = "Trending"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 20))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var trendingCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: CGFloat.dWidth(padding: 220), height: CGFloat.dHeight(padding: 280))
        layout.minimumLineSpacing = 24
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    weak var delegate: TrendingUIViewProtocol?
    
    private var model: [Results] = [] {
        didSet {
            self.showRandomMovies()
        }
    }

    override init(frame: CGRect) {
        super .init(frame: frame)
                
        addSubview(randomMoviesLabel)
        addSubview(imageViewOne)
        addSubview(imageViewTwo)
        addSubview(trendingMovieslabel)
        addSubview(trendingCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            randomMoviesLabel.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 24)),
            randomMoviesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            randomMoviesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -137)),
        
            imageViewOne.topAnchor.constraint(equalTo: randomMoviesLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            imageViewOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 25)),
            imageViewOne.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 210)),
            imageViewOne.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 150)),
            
            imageViewTwo.topAnchor.constraint(equalTo: randomMoviesLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            imageViewTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -25)),
            imageViewTwo.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 210)),
            imageViewTwo.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 150)),
        
            trendingMovieslabel.topAnchor.constraint(equalTo: imageViewTwo.bottomAnchor, constant: CGFloat.dHeight(padding: 12)),
            trendingMovieslabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            trendingMovieslabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -252)),
            
            trendingCollectionView.topAnchor.constraint(equalTo: trendingMovieslabel.bottomAnchor, constant: CGFloat.dHeight(padding: 4)),
            trendingCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trendingCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trendingCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func dataAndRefreshed(model: [Results]) {
        self.model = model
        trendingCollectionView.reloadData()
    }
    
    private func randomMovie() -> Results? {
        return model.randomElement()
    }
    
    private func showRandomMovies() {
        imageViewOne.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(self.randomMovie()?.poster_path ?? "")" ))
        imageViewTwo.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(self.randomMovie()?.poster_path ?? "")" ))
        imageViewOne.reloadInputViews()
        imageViewTwo.reloadInputViews()
    }
}

extension TrendingUIView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell
        
        let movie = model[indexPath.item]
        cell.showModel(model: movie)
        
        return cell
    }
}
