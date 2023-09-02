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
    
    private var imageItems: [SelectedImageModelRealm] = [] {
        didSet {
            
        }
    }
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
        
        let favs = storageManager?.getAll(SelectedImageModelRealm.self).filter ({ $0.userId == userInfoManager?.getUserUid() })
        
        if let index = favs?.firstIndex(where: { $0.imageData == imageData }) {
            if let item = favs?[index] {
                storageManager?.delete(item, onError: { error in
                    print(error.localizedDescription)
                })
            } else {
                print("Önceki fotoğrafı bulma hatası")
                return
            }
        } else {
            print("Önceki fotoğraf bulunamadı")
        }
        
        let userId = userInfoManager?.getUserUid()
        
        let favModel = SelectedImageModelRealm(userId: userId,
                                               imageData: imageData)
        
        storageManager?.create(favModel, onError: { error in
            print(error.localizedDescription)
        })
    }
    
    func getProfileImage() {
        self.imageItems = storageManager?.getAll(SelectedImageModelRealm.self).filter ({ $0.userId == userInfoManager?.getUserUid() }) ?? []
        presenter?.showImageItems(model: imageItems)
    }
}
