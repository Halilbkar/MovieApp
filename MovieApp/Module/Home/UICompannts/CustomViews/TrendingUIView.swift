//
//  TrendingUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

class TrendingUIView: UIView {
    
    private lazy var label: UILabel = {
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
        layout.itemSize = CGSize(width: CGFloat.dWidth(padding: 258), height: CGFloat.dHeight(padding: 336))
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

    override init(frame: CGRect) {
        super .init(frame: frame)
                
        addSubview(label)
        addSubview(trendingCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 5)),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -252)),
            
            trendingCollectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: CGFloat.dHeight(padding: 24)),
            trendingCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trendingCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trendingCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}

extension TrendingUIView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell
        
        return cell
    }
}