//
//  DetailInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 5.09.2023.
//

import Foundation

protocol DetailInteractorInputs {
    func getTrailer()
}

protocol DetailInteractorOutputs: AnyObject {
    func trailerModel(model: MovieAndTrailerModel)
}

class DetailInteractor {
    
    weak var presenter: DetailInteractorOutputs?
    private var movie: Results
    
    init(movie: Results) {
        self.movie = movie
    }
}

extension DetailInteractor: DetailInteractorInputs {
    
    func getTrailer() {
        Task {
            try await MoviesService.fetchTrailerMovie(category: .trailer(query: movie.original_title + "trailer")) { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let trailer):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        let model: MovieAndTrailerModel = .init(id: trailer.items[0].id, movie: movie)
                        self.presenter?.trailerModel(model: model)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
