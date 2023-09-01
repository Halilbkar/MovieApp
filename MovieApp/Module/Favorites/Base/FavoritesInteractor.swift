//
//  FavoritesInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import Foundation

protocol FavoritesInteractorInputs {
    func getFavorites()
    func showFavorites() -> [FavoritesMoviesModel]
    func deleteFavMovie(indexPath: IndexPath)
    func deleteAll()
}

protocol FavoritesInteractorOutputs: AnyObject {
    func dataRefreshed()
}

final class FavoritesInteractor {
    weak var presenter: FavoritesInteractorOutputs?
    private let storageManager: RealmManagerProtocol?
    private let userInfoManager: UserInfoManagerProtocol?
    
    init(storageManager: RealmManagerProtocol, userInfoManager: UserInfoManagerProtocol) {
        self.storageManager = storageManager
        self.userInfoManager = userInfoManager
    }
    
    private var favorites: [FavoritesMoviesModel] = [] {
        didSet {
            presenter?.dataRefreshed()
        }
    }
}

extension FavoritesInteractor: FavoritesInteractorInputs {
    func getFavorites() {
        self.favorites = storageManager?.getAll(FavoritesMoviesModel.self).filter ({ $0.userId == userInfoManager?.getUserUid() }) ?? []
    }
    
    func showFavorites() -> [FavoritesMoviesModel] {
        return self.favorites
    }
    
    func deleteFavMovie(indexPath: IndexPath) {
        storageManager?.delete(self.favorites[indexPath.row], onError: { error in
            print(error.localizedDescription)
        })
        self.favorites.remove(at: indexPath.row)
    }
    
    func deleteAll() {
        for favorite in favorites {
            storageManager?.delete(favorite, onError: { error in
                print(error.localizedDescription)
            })
        }
        self.favorites.removeAll()
    }
    
    
}
