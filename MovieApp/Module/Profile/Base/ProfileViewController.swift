//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func setBackgroundColor(color: String)
    func prepareUserInfoView()
    func prepareProfileItemView()
    func showUserInfo(model: CurrentUserModel?)
    func showImageItems(model: [SelectedImageModelRealm]?)
}

class ProfileViewController: UIViewController {
    
    private lazy var userInfoUIView: UserInfoUIView = {
        let view = UserInfoUIView()
        
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var profileItemUIView: ProfileItemUIView = {
        let view = ProfileItemUIView()
        
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
   
    internal var presenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    deinit {
        print("DEİNİT \(self.classForCoder)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
     
            userInfoUIView.topAnchor.constraint(equalTo: view.topAnchor),
            userInfoUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userInfoUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userInfoUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 250)),
            
            profileItemUIView.topAnchor.constraint(equalTo: userInfoUIView.bottomAnchor),
            profileItemUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileItemUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileItemUIView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 550)),
        ])
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func setBackgroundColor(color: String) {
        view.backgroundColor = UIColor(named: color)
    }
    
    func prepareUserInfoView() {
        view.addSubview(userInfoUIView)
    }
    
    func prepareProfileItemView() {
        view.addSubview(profileItemUIView)
    }
    
    func showUserInfo(model: CurrentUserModel?) {
        userInfoUIView.showModel(model: model)
    }
    
    func showImageItems(model: [SelectedImageModelRealm]?) {
        userInfoUIView.showProfileImage(model: model)
    }
}

extension ProfileViewController: ProfileItemUIViewProtocol {
    func signOutTapped() {
        presenter.signOutTapped()
    }
}

extension ProfileViewController: UserInfoUIViewProtocol {
    func toImagePicker(imagePicker: UIImagePickerController) {
        presenter.toImagePicker(imagePicker: imagePicker)
    }
    
    func selectedImage(imageData: Data) {
        presenter.selectedImage(imageData: imageData)
    }
}
