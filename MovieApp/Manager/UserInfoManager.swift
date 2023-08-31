//
//  UserInfoManage.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation
import FirebaseAuth

protocol UserInfoManagerProtocol {
    func getUserProfilePictureAndEmail(completion: @escaping (_ photo: String?, _ name: String?) -> Void)
    func getUserUid() -> String?
}

final class UserInfoManager: UserInfoManagerProtocol {
    func getUserProfilePictureAndEmail(completion: @escaping (_ photo: String?, _ name: String?) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            let profileImageURL = currentUser.photoURL
            completion(profileImageURL?.absoluteString, currentUser.displayName)
        } else {
            completion(nil, nil)
        }
    }
    
    func getUserUid() -> String? {
        return Auth.auth().currentUser?.uid
    }
}

