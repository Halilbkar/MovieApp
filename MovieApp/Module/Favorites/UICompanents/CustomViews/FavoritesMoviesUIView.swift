//
//  FavoritesMoviesUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import UIKit

protocol FavoritesMoviesUIViewProtocol: AnyObject {
    func showFavorites() -> [FavoritesMoviesModel]?
    func deleteFavMovie(indexPath: IndexPath)
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
    
    weak var delegate: FavoritesMoviesUIViewProtocol?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(label)
        addSubview(favoritesTableView)
        addSubview(emptyLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 60)),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat.dWidth(padding: 10)),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat.dWidth(padding: -10)),
            
            favoritesTableView.topAnchor.constraint(equalTo: label.bottomAnchor),
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
    
    func dataRefreshed() {
        favoritesTableView.reloadData()
    }
    
    private func isEmpty() -> Int {
        let itemCount = delegate?.showFavorites()?.count ?? 0
        if itemCount > 0 {
            emptyLabel.isHidden = true
            favoritesTableView.isHidden = false
        } else {
            emptyLabel.isHidden = false
            favoritesTableView.isHidden = true
        }
        return itemCount
    }
}

extension FavoritesMoviesUIView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isEmpty()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        
        cell.showMovies(model: delegate?.showFavorites()?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") { [weak self] _, _, completion in
            guard let self else { return }
            
            self.delegate?.deleteFavMovie(indexPath: indexPath)
            completion(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeAction])
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        
        return swipeConfiguration
    }
}
