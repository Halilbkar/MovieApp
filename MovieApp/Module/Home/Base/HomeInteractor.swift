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
    func getUserProfilePictureAndEmail()
}

protocol HomeInteractorOutputs: AnyObject {
    func dataRefreshed()
    func showMoviesImage()
    func showProfileImageAndEmail(model: CurrentUserModel)
}

class HomeInteractor {
    weak var presenter: HomeInteractorOutputs?
    private let service: MoviesServiceProtocol?
    private let userInfoManager: UserInfoManagerProtocol?
    
    private var movies: [Results] = [] {
        didSet {
            presenter?.dataRefreshed()
            presenter?.showMoviesImage()
        }
    }
        
    init(service: MoviesServiceProtocol, userInfoManager: UserInfoManagerProtocol) {
        self.service = service
        self.userInfoManager = userInfoManager
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
    
    func getUserProfilePictureAndEmail() {
        userInfoManager?.getUserProfilePictureAndEmail(completion: { [weak self] photo, name in
            guard let self else { return }
            
            let model: CurrentUserModel = .init(profileImageURLString: photo, name: name)
            self.presenter?.showProfileImageAndEmail(model: model)
        })
    }
}
