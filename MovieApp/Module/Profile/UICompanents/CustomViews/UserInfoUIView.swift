//
//  UserInfoUIView.swift
//  MovieApp
//
//  Created by Halil Bakar on 31.08.2023.
//

import UIKit
import SDWebImage

protocol UserInfoUIViewProtocol: AnyObject {
    func toImagePicker(imagePicker: UIImagePickerController)
    func selectedImage(imageData: Data)
}

class UserInfoUIView: UIView {
    
    private lazy var backView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "background")
        view.layer.cornerRadius = CGFloat.dWidth(padding: 50)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        
        label.text = "Test"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: CGFloat.dWidth(padding: 12))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = CGFloat.dWidth(padding: 60)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true

        return imageView
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        return picker
    }()
    
    private var model: CurrentUserModel?
    
    weak var delegate: UserInfoUIViewProtocol?
    
    private var profileModel = [SelectedImageModelRealm]()
    
    let imageLogo = "https://img.freepik.com/free-vector/branding-identity-corporate-vector-logo-m-design_460848-10168.jpg?w=996&t=st=1693574825~exp=1693575425~hmac=d0503a2fb61f88700c909b2f9ef4c99bc0d36916a9e736fca837746f60a66799"
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(backView)
        addSubview(label)
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 55)),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 150)),
            
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat.dHeight(padding: 90)),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat.dHeight(padding: 120)),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat.dWidth(padding: 120))
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - ImagePicker Action

extension UserInfoUIView {
    @objc private func imageViewTapped() {
        DispatchQueue.main.async {
            if self.model?.profileImageURLString == nil {
                self.delegate?.toImagePicker(imagePicker: self.imagePicker)
            } else {
                return
            }
        }
    }
}

// MARK: - UserInfo Model Configure

extension UserInfoUIView {
    func showModel(model: CurrentUserModel?) {
        self.model = model

        label.text = model?.name ?? ""
        imageView.sd_setImage(with: URL(string: model?.profileImageURLString ?? imageLogo))
    }
    
    func showProfileImage(model: [SelectedImageModelRealm]?) {
        if self.model?.profileImageURLString == nil {
            guard let model else { return }
            if let modelItem = model.first {
                if let getImage = modelItem.imageData {
                    imageView.image = UIImage(data: getImage)
                } else {
                    print("Veri çekilemedi.")
                }
            }
        }
    }
}

// MARK: - ImagePicker Protocols

extension UserInfoUIView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
            
            if let imageData = pickedImage.toData() {
                self.delegate?.selectedImage(imageData: imageData)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


