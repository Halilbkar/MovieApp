//
//  ProfileRowItem.swift
//  MovieApp
//
//  Created by Halil Bakar on 1.09.2023.
//

import Foundation
import UIKit.UIImage

enum ProfileRowItem: CaseIterable {
    case contactUs
    case privacyPolicy
    case rateUs
    
    var title: String {
        switch self {
        case .contactUs:
            return "Contact Us"
        case .privacyPolicy:
            return "Privacy Policy"
        case .rateUs:
            return "Rate Us"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .contactUs:
            return UIImage(systemName: "phone")
        case .privacyPolicy:
            return UIImage(systemName: "wallet.pass")
        case .rateUs:
            return UIImage(systemName: "hand.point.up")
        }
    }
}
