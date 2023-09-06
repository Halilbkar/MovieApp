//
//  DetailUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 5.09.2023.
//

import UIKit
import WebKit

class DetailUIView: UIView {
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()

        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Movie Name"
        label.backgroundColor = .white.withAlphaComponent(0.1)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 16))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var pointLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Point"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 12))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Date"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 12))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var synopsisLabel: UILabel = {
        let label = UILabel()
        
        label.text = " Synopsis "
        label.backgroundColor = .white.withAlphaComponent(0.1)
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 16))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Detail"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: CGFloat.dWidth(padding: 12))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var model: TrailerItems?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(movieImageView)
        addSubview(nameLabel)
        addSubview(pointLabel)
        addSubview(dateLabel)
        addSubview(synopsisLabel)
        addSubview(detailLabel)
        addSubview(webView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 250)),
            
            nameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 10)),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -10)),
            nameLabel.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 24)),

            webView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 10)),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -10)),
            webView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 200)),
            
            synopsisLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            synopsisLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 10)),
            synopsisLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -10)),
            synopsisLabel.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 24)),

            detailLabel.topAnchor.constraint(equalTo: synopsisLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 20)),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -20)),
            
            pointLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            pointLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 20)),
            
            dateLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            dateLabel.leadingAnchor.constraint(equalTo: pointLabel.trailingAnchor, constant: CGFloat.dWidth(padding: 40)),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func trailerModel(model: MovieAndTrailerModel) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.id.videoId)") else { return }
        webView.load(URLRequest(url: url))
        
        movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(model.movie.poster_path)"))
        
        nameLabel.text = " \(model.movie.original_title.uppercased()) "
 
        let voteFormat = String(format: "%.1f", model.movie.vote_average)
        pointLabel.text = String("IMDB : \(voteFormat)")
        
        dateLabel.text = "Date: \(model.movie.release_date)"
        
        detailLabel.text = model.movie.overview
    }
}
