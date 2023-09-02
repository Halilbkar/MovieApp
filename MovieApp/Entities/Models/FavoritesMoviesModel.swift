//
//  FavoritesMoviesModel.swift
//  MovieApp
//
//  Created by Halil Bakar on 1.09.2023.
//

import Foundation
import RealmSwift

class FavoritesMoviesModel: Object {
    @Persisted var userId: String?
    @Persisted var movieId: Int
    @Persisted var movieImage: String
    @Persisted var movieTitle: String
    @Persisted var release_date: String
    @Persisted var vote_average: Double
    
    convenience init(userId: String?, movieId: Int, movieImage: String, movieTitle: String, release_date: String, vote_average: Double) {
        self.init()
        self.userId = userId
        self.movieId = movieId
        self.movieImage = movieImage
        self.movieTitle = movieTitle
        self.release_date = release_date
        self.vote_average = vote_average
    }
}

class SelectedImageModelRealm: Object {
    @Persisted var userId: String?
    @Persisted var imageData: Data?
    
    convenience init(userId: String?, imageData: Data?) {
        self.init()
        self.userId = userId
        self.imageData = imageData
    }
}
