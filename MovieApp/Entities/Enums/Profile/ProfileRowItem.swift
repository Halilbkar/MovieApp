//
//  ProfileRowItem.swift
//  MovieApp
//
//  Created by Halil Bakar on 1.09.2023.
//

import Foundation
import UIKit.UIImage

enum ProfileRowItem {
    case name
    case email
    case phoneNumber
    
    var title: String {
        switch self {
        case .name:
            return "Your name"
        case .email:
            return "Your email"
        case .phoneNumber:
            return "Your Phone Number"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .name:
            return UIImage(systemName: "map")
        case .email:
            return UIImage(systemName: "creditcard")
        case .phoneNumber:
            return UIImage(systemName: "wallet.pass")
        }
    }
}

struct ProfileRowItemModel {
    let item: ProfileRowItem
}
