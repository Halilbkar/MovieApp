//
//  HomeInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol HomeInteractorInputs {
    func getData()
    func getUserProfilePictureAndEmail()
    func getProfileImage()
}

protocol HomeInteractorOutputs: AnyObject {
    func dataAndRefreshed(model: [Results])
    func showProfileImageAndEmail(model: CurrentUserModel)
    func showImageItems(model: [SelectedImageModelRealm])
}

class HomeInteractor {
    weak var presenter: HomeInteractorOutputs?
    
    private var imageItems: [SelectedImageModelRealm] = []
}

extension HomeInteractor: HomeInteractorInputs {
    func getData() {
        Task {
            try await MoviesService.fetchCategoryMovies(category: .trending) { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let movies):
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        presenter?.dataAndRefreshed(model: movies.results)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
        
    func getUserProfilePictureAndEmail() {
        UserInfoManager.shared.getUserProfilePictureAndEmail(completion: { [weak self] photo, name in
            guard let self else { return }

            let model: CurrentUserModel = .init(profileImageURLString: photo, name: name)
            self.presenter?.showProfileImageAndEmail(model: model)
        })
    }
    
    func getProfileImage() {
        self.imageItems = RealmManager.shared.getAll(SelectedImageModelRealm.self).filter ({ $0.userId == UserInfoManager.shared.getUserUid() })
        presenter?.showImageItems(model: imageItems)
    }
}
