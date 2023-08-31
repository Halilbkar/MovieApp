//
//  PreviewUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit
import SDWebImage

protocol PreviewUIViewProtocol: AnyObject {
    func showMoviesImage() -> Results?
}

class PreviewUIView: UIView {
    
    private lazy var label: UILabel = {
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
    
    weak var delegate: PreviewUIViewProtocol?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
                
        addSubview(label)
        addSubview(imageViewOne)
        addSubview(imageViewTwo)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 24)),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 24)),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -137)),
        
            imageViewOne.topAnchor.constraint(equalTo: label.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            imageViewOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 25)),
            imageViewOne.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 210)),
            imageViewOne.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 150)),
            
            imageViewTwo.topAnchor.constraint(equalTo: label.bottomAnchor, constant: CGFloat.dHeight(padding: 20)),
            imageViewTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -25)),
            imageViewTwo.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 210)),
            imageViewTwo.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 150))
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func showMoviesImage() {
        imageViewOne.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(delegate?.showMoviesImage()?.poster_path ?? "")" ))
        imageViewTwo.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(delegate?.showMoviesImage()?.poster_path ?? "")" ))
        imageViewOne.reloadInputViews()
        imageViewTwo.reloadInputViews()
    }
}
