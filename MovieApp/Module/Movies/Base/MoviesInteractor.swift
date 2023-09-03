//
//  MoviewInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol MoviesInteractorInputs {
//    func getTrendingData()
//    func getTopRatedData()
//    func getPopularData()
//    func getUpComingData()
//    func getDiscoverData()
    func getCategoryData(category: MoviesEndpoint)
    func showMoviesTitle() -> [MoviesTitle]
    func isFav(model: Results?) -> Bool
    func addFav(model: Results?)
}

protocol MoviesInteractorOutputs: AnyObject {
    func dataRefreshed(movies: [Results])
}

final class MoviesInteractor {
    var presenter: MoviesInteractorOutputs?
    var service: MoviesServiceProtocol?
    var storageManager: RealmManagerProtocol?
    var userInfoManager: UserInfoManagerProtocol?
        
    init(service: MoviesServiceProtocol, storageManager: RealmManagerProtocol, userInfoManager: UserInfoManagerProtocol) {
        self.service = service
        self.storageManager = storageManager
        self.userInfoManager = userInfoManager
    }

    private var moviesTitle = MoviesTitle.allCases
}

extension MoviesInteractor: MoviesInteractorInputs {
    func getCategoryData(category: MoviesEndpoint) {
        Task {
            try await service?.fetchCategoryMovies(category: category) { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        presenter?.dataRefreshed(movies: movies.results)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
//    func getTopRatedData() {
//        Task {
//            try await service?.fetchTopRatedMovies { [weak self] result in
//                guard let self else { return }
//
//                switch result {
//                case .success(let movies):
//                    DispatchQueue.main.async { [weak self] in
//                        guard let self else { return }
//                        presenter?.dataRefreshed(movies: movies.results)
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//
//    func getPopularData() {
//        Task {
//            try await service?.fetchPopularMovies { [weak self] result in
//                guard let self else { return }
//
//                switch result {
//                case .success(let movies):
//                    DispatchQueue.main.async { [weak self] in
//                        guard let self else { return }
//                        presenter?.dataRefreshed(movies: movies.results)
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//
//    func getUpComingData() {
//        Task {
//            try await service?.fetchUpComingMovies { [weak self] result in
//                guard let self else { return }
//
//                switch result {
//                case .success(let movies):
//                    DispatchQueue.main.async { [weak self] in
//                        guard let self else { return }
//                        presenter?.dataRefreshed(movies: movies.results)
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//
//    func getDiscoverData() {
//        Task {
//            try await service?.fetchDiscoverMovies { [weak self] result in
//                guard let self else { return }
//
//                switch result {
//                case .success(let movies):
//                    DispatchQueue.main.async { [weak self] in
//                        guard let self else { return }
//                        presenter?.dataRefreshed(movies: movies.results)
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//
//    func getTrendingData() {
//        Task {
//            try await service?.fetchTrendingMovies { [weak self] result in
//                guard let self else { return }
//
//                switch result {
//                case .success(let movies):
//                    DispatchQueue.main.async { [weak self] in
//                        guard let self else { return }
//                        presenter?.dataRefreshed(movies: movies.results)
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
    
    func showMoviesTitle() -> [MoviesTitle] {
        return self.moviesTitle
    }
    
    func isFav(model: Results?) -> Bool {
        let favs = storageManager?.getAll(FavoritesMoviesModel.self).filter ({ $0.userId == userInfoManager?.getUserUid() })
        
        return favs?.filter({ $0.movieTitle == model?.original_title }).isEmpty == true ? false : true
    }
    
    func addFav(model: Results?) {
        guard let model else { return }
        
        if !isFav(model: model) {
            
            let favModel = FavoritesMoviesModel(userId: userInfoManager?.getUserUid(),
                                                movieId: model.id,
                                                movieImage: model.poster_path,
                                                movieTitle: model.original_title,
                                                release_date: model.release_date,
                                                vote_average: model.vote_average)
            
            storageManager?.create(favModel, onError: { error in
                print(error.localizedDescription)
            })
            
        } else {
            let favs = storageManager?.getAll(FavoritesMoviesModel.self).filter ({ $0.userId == userInfoManager?.getUserUid() })
            
            if let index = favs?.firstIndex(where: { $0.movieId == model.id }) {
                if let item = favs?[index] {
                    storageManager?.delete(item, onError: { error in
                        print(error.localizedDescription)
                    })
                }
            }
        }
    }
}
