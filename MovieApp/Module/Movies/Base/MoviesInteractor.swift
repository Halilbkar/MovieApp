//
//  MoviewInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol MoviesInteractorInputs {
    func getTrendingData()
    func getTopRatedData()
    func getPopularData()
    func getUpComingData()
    func getDiscoverData()
    func showMovies() -> [Results]
    func showMoviesTitle() -> [MoviesTitle]
}

protocol MoviesInteractorOutputs: AnyObject {
    func dataRefreshed()
}

final class MoviesInteractor {
    var presenter: MoviesInteractorOutputs?
    var service: MoviesServiceProtocol?
            
    private var movies: [Results] = [] {
        didSet {
            presenter?.dataRefreshed()
        }
    }
    
    private var moviesTitle = MoviesTitle.allCases
    
    init(service: MoviesServiceProtocol) {
        self.service = service
    }
}

extension MoviesInteractor: MoviesInteractorInputs {
    func getTopRatedData() {
        Task {
            try await service?.fetchTopRatedMovies { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.movies = movies.results
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getPopularData() {
        Task {
            try await service?.fetchPopularMovies { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.movies = movies.results
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getUpComingData() {
        Task {
            try await service?.fetchUpComingMovies { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.movies = movies.results
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getDiscoverData() {
        Task {
            try await service?.fetchDiscoverMovies { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.movies = movies.results
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getTrendingData() {
        Task {
            try await service?.fetchTrendingMovies { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.movies = movies.results
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func showMovies() -> [Results] {
        return self.movies
    }
    
    func showMoviesTitle() -> [MoviesTitle] {
        return self.moviesTitle
    }
}
