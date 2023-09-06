//
//  MoviesService.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation

typealias MoviesHandler = (Result<MovieModel, NetworkError>) -> Void
typealias MovieTrailerHandler = (Result<TrailerModel, NetworkError>) -> Void

protocol MoviesServiceProtocol {
    static func fetchCategoryMovies(category: MoviesEndpoint, completion: @escaping MoviesHandler) async throws
    static func fetchTrailerMovie(category: MoviesEndpoint, completion: @escaping MovieTrailerHandler) async throws
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
    
    static func fetchTrailerMovie(category: MoviesEndpoint, completion: @escaping MovieTrailerHandler) async throws {
        do {
            let trailer: TrailerModel = try await NetworkManager.request(endpoint: category)
            completion(.success(trailer))
        } catch let error as NetworkError {
            print("Fetch movies trailer error: \(error.localizedDescription)")
            throw error
        }
    }
}
