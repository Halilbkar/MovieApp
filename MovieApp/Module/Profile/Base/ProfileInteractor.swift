//
//  ProfileInteractor.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation

protocol ProfileInteractorInputs {
    func getuserInfo()
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
    
    private var imageItems: [SelectedImageModelRealm] = []
}

extension ProfileInteractor: ProfileInteractorInputs {
    func getuserInfo() {
        UserInfoManager.shared.getUserProfilePictureAndEmail(completion: { [weak self] photo, name in
            guard let self else { return }
            let model: CurrentUserModel = .init(profileImageURLString: photo, name: name)
            presenter?.showUserInfo(model: model)
        })
    }
    
    func signOut() {
        AuthManager.shared.signOut(completion: { [weak self] results in
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
        
        guard let userId = UserInfoManager.shared.getUserUid() else { return }
        
        if let previousImage = RealmManager.shared.getAll(SelectedImageModelRealm.self).first(where: { $0.userId == userId }) {
            RealmManager.shared.delete(previousImage) { error in
                print(error.localizedDescription)
            }
        }
        
        let newSelectedImage = SelectedImageModelRealm(userId: userId, imageData: imageData)
        RealmManager.shared.create(newSelectedImage, onError: { error in
            print(error.localizedDescription)
        })
    }

    func getProfileImage() {
        self.imageItems = RealmManager.shared.getAll(SelectedImageModelRealm.self).filter ({ $0.userId == UserInfoManager.shared.getUserUid() })
        presenter?.showImageItems(model: imageItems)
    }
}
