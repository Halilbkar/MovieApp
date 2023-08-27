//
//  HomeInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol HomeInteractorInputs {
    func getData()
    func showMovies() -> [Results]
}

protocol HomeInteractorOutputs: AnyObject {
    func dataRefreshed()
}

class HomeInteractor {
    weak var presenter: HomeInteractorOutputs?
    private let service: MoviesServiceProtocol?
    
    private var movies: [Results] = [] {
        didSet {
            presenter?.dataRefreshed()
        }
    }
        
    init(service: MoviesServiceProtocol?) {
        self.service = service
    }
}

extension HomeInteractor: HomeInteractorInputs {
    func getData() {
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
}
