//
//  ProfilePresenter.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation
import UIKit.UIImagePickerController

protocol ProfilePresenterProtocol {
    func viewDidLoad()
    func showItems() -> [ProfileRowItemModel]?
    func signOutTapped()
    func toImagePicker(imagePicker: UIImagePickerController)
    func selectedImage(imageData: Data)
}

class ProfilePresenter {
    private weak var view: ProfileViewProtocol?
    private let interactor: ProfileInteractorInputs?
    private let router: ProfileRouterProtocol?
    
    init(view: ProfileViewProtocol, interactor: ProfileInteractorInputs, router: ProfileRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func viewDidLoad() {
        view?.setBackgroundColor(color: "background")
        view?.prepareUserInfoView()
        view?.prepareProfileItemView()
        interactor?.getuserInfo()
        interactor?.getProfileImage()
    }
    
    func showItems() -> [ProfileRowItemModel]? {
        interactor?.showItems()
    }
    
    func signOutTapped() {
        interactor?.signOut()
    }
    
    func toImagePicker(imagePicker: UIImagePickerController) {
        router?.toImagePicker(imagePicker: imagePicker)
    }
    
    func selectedImage(imageData: Data) {
        interactor?.selectedImage(imageData: imageData)
    }
}

extension ProfilePresenter: ProfileInteractorOutputs {
    func showUserInfo(model: CurrentUserModel?) {
        view?.showUserInfo(model: model)
    }
    
    func signOutCompleted() {
        router?.toLogin()
    }
    
    func showImageItems(model: [SelectedImageModelRealm]) {
        view?.showImageItems(model: model)
    }
}

