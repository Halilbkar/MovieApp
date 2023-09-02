//
//  +UIImage.swift
//  MovieApp
//
//  Created by Halil Bakar on 2.09.2023.
//

import Foundation
import UIKit

extension UIImage {
    func toData() -> Data? {
        return self.jpegData(compressionQuality: 1.0)
    }
}
