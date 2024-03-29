//
//  FavoritesMoviesUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import UIKit

protocol FavoritesMoviesUIViewProtocol: AnyObject {
    func deleteFavMovie(movie: FavoritesMoviesModel)
    func deleteAll()
}

class FavoritesMoviesUIView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "Movies you want to watch later are here!"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 20))
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        
        label.text = "You haven't added a movie to your list yet."
        label.textColor = .systemGray5
        label.alpha = 0.5
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 20))
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = UIColor(named: "background")
        
        return tableView
    }()
    
    private lazy var removeAllButton: UIButton = {
        var config = UIButton.Configuration.filled()
        
        config.title = "Clear List"
        config.baseBackgroundColor = .systemGray5.withAlphaComponent(0.2)
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.buttonSize = .medium
        config.attributedTitle?.font = UIFont.boldSystemFont(ofSize: CGFloat.dWidth(padding: 12))
        
        let button = UIButton(configuration: config)
        
        button.addTarget(self, action: #selector(removeAll), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var sortedButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "list.and.film"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: FavoritesMoviesUIViewProtocol?
    
    private var favoriteMoviesModel: [FavoritesMoviesModel] = [] {
        didSet {
            favoritesTableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(label)
        addSubview(removeAllButton)
        addSubview(sortedButton)
        addSubview(favoritesTableView)
        addSubview(emptyLabel)
        
        sortedButtonTapped()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 60)),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 10)),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -10)),
            
            removeAllButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: CGFloat.dHeight(padding: 4)),
            removeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -10)),
            
            sortedButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: CGFloat.dHeight(padding: 4)),
            sortedButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 10)),

            favoritesTableView.topAnchor.constraint(equalTo: removeAllButton.bottomAnchor, constant: CGFloat.dHeight(padding: 8)),
            favoritesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 20)),
            emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -20)),
            emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func modelCount() -> Int {
        let modelCount = favoriteMoviesModel.count
        if modelCount > 0 {
            emptyLabel.isHidden = true
            favoritesTableView.isHidden = false
        } else {
            emptyLabel.isHidden = false
            favoritesTableView.isHidden = true
        }
        return modelCount
    }
    
    internal func favMoviesData(model: [FavoritesMoviesModel]) {
        self.favoriteMoviesModel = model
    }
    
    @objc private func removeAll() {
        delegate?.deleteAll()
        self.favoriteMoviesModel.removeAll()
    }
    
    private func sortedButtonTapped() {
        
        var state: Bool = true
        
        let menu = UIMenu(title: "Sort Movies", children: [

            UIAction(title: "Name", handler: { action in
                 
                self.favoriteMoviesModel.sort { $0.movieTitle < $1.movieTitle }
                
            }),
            UIAction(title: "Date", handler: { _ in
                self.favoriteMoviesModel.sort { $0.release_date < $1.release_date }
            }),
            
            UIAction(title: "IMDB", handler: { _ in
                if state {
                    self.favoriteMoviesModel.sort { $0.vote_average < $1.vote_average }
                } else {
                    self.favoriteMoviesModel.sort { $0.vote_average > $1.vote_average }
                }
                
                state.toggle()
            })])
        
        sortedButton.menu = menu
        sortedButton.showsMenuAsPrimaryAction = true
    }
}

extension FavoritesMoviesUIView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        
        cell.showMovies(model: favoriteMoviesModel[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.dHeight(padding: 150)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") { [weak self] _, _, completion in
            guard let self else { return }
            
            self.delegate?.deleteFavMovie(movie: favoriteMoviesModel[indexPath.row])
            favoriteMoviesModel.remove(at: indexPath.row)
            completion(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
}
