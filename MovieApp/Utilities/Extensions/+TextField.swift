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
}
