//
//  MoviesService.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation

typealias MoviesHandler = (Result<MovieModel, NetworkError>) -> Void
typealias MovieDetailHandler = (Result<MovieModel, NetworkError>) -> Void

protocol MoviesServiceProtocol {
    static func fetchCategoryMovies(category: MoviesEndpoint, completion: @escaping MoviesHandler) async throws
}

final class MoviesService {
    
}

extension MoviesService: MoviesServiceProtocol {

    static func fetchCategoryMovies(category: MoviesEndpoint, completion: @escaping MoviesHandler) async throws {
        do {
            let movies: MovieModel = try await NetworkManager.request(endpoint: category)
            completion(.success(movies))
        } catch let error as NetworkError {
            print("Fetch upcoming movies error: \(error.localizedDescription)")
            throw error
        }
    }
}
