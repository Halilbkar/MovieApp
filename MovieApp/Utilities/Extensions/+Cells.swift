//
//  +Cells.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import Foundation
import UIKit.UITableViewCell
import UIKit.UICollectionViewCell

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}
