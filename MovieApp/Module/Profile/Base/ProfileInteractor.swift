//
//  ProfileInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol ProfileInteractorInputs {
    func getuserInfo()
    func showItems() -> [ProfileRowItemModel]
    func signOut()
}

protocol ProfileInteractorOutputs: AnyObject {
    func showUserInfo(model: CurrentUserModel?)
    func signOutCompleted()
}

class ProfileInteractor  {
    var presenter: ProfileInteractorOutputs?
    private let userInfoManager: UserInfoManagerProtocol?
    private let authManager: AuthManagerProtocol?
    
    private let rowItems: [ProfileRowItemModel] = [
        .init(item: .name),
        .init(item: .email),
        .init(item: .phoneNumber)
    ]

    init( userInfoManager: UserInfoManagerProtocol, authManager: AuthManagerProtocol) {
        self.userInfoManager = userInfoManager
        self.authManager = authManager
    }
}

extension ProfileInteractor: ProfileInteractorInputs {
    func getuserInfo() {
        userInfoManager?.getUserProfilePictureAndEmail(completion: { [weak self] photo, email in
            guard let self else { return }
            let model: CurrentUserModel = .init(profileImageURLString: photo, userEmail: email)
            presenter?.showUserInfo(model: model)
        })
    }
    
    func showItems() -> [ProfileRowItemModel] {
        return self.rowItems
    }
    
    func signOut() {
        authManager?.signOut(completion: { [weak self] results in
            guard let self else { return }
            
            switch results {
            case .success(_):
                presenter?.signOutCompleted()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
