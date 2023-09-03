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
    func selectedImage(imageData: Data?)
    func getProfileImage()
}

protocol ProfileInteractorOutputs: AnyObject {
    func showUserInfo(model: CurrentUserModel?)
    func signOutCompleted()
    func showImageItems(model: [SelectedImageModelRealm])
}

class ProfileInteractor  {
    var presenter: ProfileInteractorOutputs?
    private let userInfoManager: UserInfoManagerProtocol?
    private let authManager: AuthManagerProtocol?
    private let storageManager: RealmManagerProtocol?
    
    private let rowItems: [ProfileRowItemModel] = [
        .init(item: .name),
        .init(item: .email),
        .init(item: .phoneNumber)
    ]
    
    init( userInfoManager: UserInfoManagerProtocol, authManager: AuthManagerProtocol, storageManager: RealmManagerProtocol) {
        self.userInfoManager = userInfoManager
        self.authManager = authManager
        self.storageManager = storageManager
    }
    
    private var imageItems: [SelectedImageModelRealm] = []
}

extension ProfileInteractor: ProfileInteractorInputs {
    func getuserInfo() {
        userInfoManager?.getUserProfilePictureAndEmail(completion: { [weak self] photo, name in
            guard let self else { return }
            let model: CurrentUserModel = .init(profileImageURLString: photo, name: name)
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
    
    func selectedImage(imageData: Data?) {
        guard let imageData = imageData else { return }
        
        guard let userId = userInfoManager?.getUserUid() else { return }
        
        if let previousImage = storageManager?.getAll(SelectedImageModelRealm.self).first(where: { $0.userId == userId }) {
            storageManager?.delete(previousImage) { error in
                print(error.localizedDescription)
            }
        }
        
        let newSelectedImage = SelectedImageModelRealm(userId: userId, imageData: imageData)
        storageManager?.create(newSelectedImage, onError: { error in
            print(error.localizedDescription)
        })
    }

    func getProfileImage() {
        self.imageItems = storageManager?.getAll(SelectedImageModelRealm.self).filter ({ $0.userId == userInfoManager?.getUserUid() }) ?? []
        presenter?.showImageItems(model: imageItems)
    }
}
