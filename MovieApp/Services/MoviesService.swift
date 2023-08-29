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
    func fetchPopularMovies(completion: @escaping MoviesHandler) async throws
    func fetchTrendingMovies(completion: @escaping MoviesHandler) async throws
    func fetchTopRatedMovies(completion: @escaping MoviesHandler) async throws
    func fetchDiscoverMovies(completion: @escaping MoviesHandler) async throws
    func fetchUpComingMovies(completion: @escaping MoviesHandler) async throws
}

final class MoviesService {
    private let networkManager = NetworkManager()
}

extension MoviesService: MoviesServiceProtocol {

    func fetchPopularMovies(completion: @escaping MoviesHandler) async throws {
        do {
            let endpoint = MoviesEndpoint.popular
            let movies: MovieModel = try await networkManager.request(endpoint: endpoint)
            completion(.success(movies))
        } catch let error as NetworkError {
            print("Fetch popular movies error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchTrendingMovies(completion: @escaping MoviesHandler) async throws {
        do {
            let endpoint = MoviesEndpoint.trending
            let movies: MovieModel = try await networkManager.request(endpoint: endpoint)
            completion(.success(movies))
        } catch let error as NetworkError {
            print("Fetch trending movies error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchTopRatedMovies(completion: @escaping MoviesHandler) async throws {
        do {
            let endpoint = MoviesEndpoint.topRated
            let movies: MovieModel = try await networkManager.request(endpoint: endpoint)
            completion(.success(movies))
        } catch let error as NetworkError {
            print("Fetch top rated movies error: \(error.localizedDescription)")
            throw error
        }
    }

    func fetchDiscoverMovies(completion: @escaping MoviesHandler) async throws {
        do {
            let endpoint = MoviesEndpoint.discover
            let movies: MovieModel = try await networkManager.request(endpoint: endpoint)
            completion(.success(movies))
        } catch let error as NetworkError {
            print("Fetch discover movies error: \(error.localizedDescription)")
            throw error
        }
    }

    func fetchUpComingMovies(completion: @escaping MoviesHandler) async throws {
        do {
            let endpoint = MoviesEndpoint.upComing
            let movies: MovieModel = try await networkManager.request(endpoint: endpoint)
            completion(.success(movies))
        } catch let error as NetworkError {
            print("Fetch upcoming movies error: \(error.localizedDescription)")
            throw error
        }
    }
}
