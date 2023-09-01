//
//  FavoritesTableViewCell.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    private lazy var moviesImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.tintColor = .label
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Item"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 14))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Item"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 14))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var voteLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Item"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 14))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var model: FavoritesMoviesModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(named: "background")
        
        addSubview(moviesImageView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(voteLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            moviesImageView.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 10)),
            moviesImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 10)),
            moviesImageView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 120)),
            moviesImageView.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 80)),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 20)),
            titleLabel.leadingAnchor.constraint(equalTo: moviesImageView.trailingAnchor, constant: CGFloat.dWidth(padding: 20)),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            dateLabel.leadingAnchor.constraint(equalTo: moviesImageView.trailingAnchor, constant: CGFloat.dWidth(padding: 20)),
            
            voteLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            voteLabel.leadingAnchor.constraint(equalTo: moviesImageView.trailingAnchor, constant: CGFloat.dWidth(padding: 20))
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func showMovies(model: FavoritesMoviesModel?) {
        self.model = model
        
        titleLabel.text = model?.movieTitle
        dateLabel.text = "Date : \(model?.release_date ?? "")"
        
        guard let vote = model?.vote_average else { return }
        let voteFormat = String(format: "%.1f", vote)
        voteLabel.text = String("IMDB : \(voteFormat)")
        
        moviesImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(model?.movieImage ?? "")"))
    }
}
