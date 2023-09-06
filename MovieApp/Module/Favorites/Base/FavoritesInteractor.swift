//
//  FavoritesInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import Foundation

protocol FavoritesInteractorInputs {
    func getFavorites()
    func deleteFavMovie(movie: FavoritesMoviesModel)
    func deleteAll()
}

protocol FavoritesInteractorOutputs: AnyObject {
    func favMoviesData(model: [FavoritesMoviesModel])
}

final class FavoritesInteractor {
    weak var presenter: FavoritesInteractorOutputs?
}

extension FavoritesInteractor: FavoritesInteractorInputs {
    func getFavorites() {
        let favMovies = RealmManager.shared.getAll(FavoritesMoviesModel.self).filter ({ $0.userId == UserInfoManager.shared.getUserUid() })
        presenter?.favMoviesData(model: favMovies)
    }
    
    func deleteFavMovie(movie: FavoritesMoviesModel) {
        RealmManager.shared.delete(movie) { error in
            print(error.localizedDescription)
        }
    }
    
    func deleteAll() {
//        RealmManager.shared.deleteAll { error in
//            print(error.localizedDescription)
//        }
//
        let favMovies = RealmManager.shared.getAll(FavoritesMoviesModel.self).filter ({ $0.userId == UserInfoManager.shared.getUserUid() })
        
        for favorite in favMovies {
            RealmManager.shared.delete(favorite) { [weak self] error in
                guard let self else { return }
                print(error.localizedDescription)
            }
        }
    }
}
