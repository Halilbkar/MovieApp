//
//  GeneralError.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation

enum GeneralError: Error {
    
    case emailPasswordEmpty
    case addressInfoMissing
    case cardInfoMissing
    case emptyBasketError
    case emptyAddressOrCard
    case passwordsAreDifferent
    
    var localizedDescription: String {
        switch self {
        case .emailPasswordEmpty:
            return NSLocalizedString("Email & Password cannot be empty!", comment: "")
        case .addressInfoMissing:
            return NSLocalizedString("Address informations are missing!", comment: "")
        case .cardInfoMissing:
            return NSLocalizedString("Card informations are missing!", comment: "")
        case .emptyBasketError:
            return NSLocalizedString("Your basket is empty.", comment: "")
        case .emptyAddressOrCard:
            return NSLocalizedString("You have not selected an address or a card.", comment: "")
        case .passwordsAreDifferent:
            return NSLocalizedString("Password & TryPassword must be the same!", comment: "")
        }
    }
}
