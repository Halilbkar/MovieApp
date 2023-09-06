//
//  +TextFiled.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation
import UIKit.UITextField

extension UITextField {
    func setPlaceholder(text: String, fontSize: CGFloat, color: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: fontSize)
        ]
        attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
    
    func addBottomLine(color: UIColor, height: CGFloat) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: height)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func addLogo(image: String) {
        let logoImageView = UIImageView(image: UIImage(systemName: image)?.withTintColor(.label, renderingMode: .alwaysOriginal))
        
        self.leftView = logoImageView
        self.leftViewMode = .always
    }
    
    func addRightButton(withTitle title: String, target: Any?, action: Selector) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: title), for: .normal)
        button.tintColor = .black
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let buttonSize = CGSize(width: 80, height: self.frame.size.height)
        button.frame = CGRect(origin: .zero, size: buttonSize)
        
        self.rightView = button
        self.rightViewMode = .always
    }
}
