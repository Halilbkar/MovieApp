//
//  MoviewInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol MoviesInteractorInputs {
    func getCategoryData(category: MoviesEndpoint)
    func showMoviesTitle() -> [MoviesTitle]
    func isFav(model: Results?) -> Bool
    func addFav(model: Results?)
}

protocol MoviesInteractorOutputs: AnyObject {
    func dataAndRefreshed(model: [Results])
}

final class MoviesInteractor {
    var presenter: MoviesInteractorOutputs?

    private var moviesTitle = MoviesTitle.allCases
}

extension MoviesInteractor: MoviesInteractorInputs {
    func getCategoryData(category: MoviesEndpoint) {
        Task {
            try await MoviesService.fetchCategoryMovies(category: category) { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        presenter?.dataAndRefreshed(model: movies.results)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func showMoviesTitle() -> [MoviesTitle] {
        return self.moviesTitle
    }
    
    func isFav(model: Results?) -> Bool {
        let favs = RealmManager.shared.getAll(FavoritesMoviesModel.self).filter ({ $0.userId == UserInfoManager.shared.getUserUid() })
        
        return favs.filter({ $0.movieTitle == model?.original_title }).isEmpty == true ? false : true
    }
    
    func addFav(model: Results?) {
        guard let model else { return }
        
        if !isFav(model: model) {
            
            let favModel = FavoritesMoviesModel(userId: UserInfoManager.shared.getUserUid(),
                                                movieId: model.id,
                                                movieImage: model.poster_path,
                                                movieTitle: model.original_title,
                                                release_date: model.release_date,
                                                vote_average: model.vote_average)
            
            RealmManager.shared.create(favModel, onError: { error in
                print(error.localizedDescription)
            })
            
        } else {
            let favs = RealmManager.shared.getAll(FavoritesMoviesModel.self).filter ({ $0.userId == UserInfoManager.shared.getUserUid() })
            
            if let index = favs.firstIndex(where: { $0.movieId == model.id }) {
                RealmManager.shared.delete(favs[index], onError: { error in
                    print(error.localizedDescription)
                })
            }
        }
    }
}
