//
//  RootWindowManager.swift
//  MovieApp
//
//  Created by Halil Bakar on 3.09.2023.
//

import Foundation
import UIKit.UIViewController

protocol RootWindowManagerProtocol {
    func changeRootViewController(_ viewController: UIViewController, animated: Bool)
}

final class RootWindowManager: RootWindowManagerProtocol {
    
    static let shared = RootWindowManager()
    
    internal var window: UIWindow?
    
    private init() {}
    
    func changeRootViewController(_ viewController: UIViewController, animated: Bool) {
        guard let window = window else {
            return
        }
        let customOptions: UIView.AnimationOptions = [.curveEaseInOut, .transitionCrossDissolve]

        if animated {
                    UIView.transition(
                        with: window,
                        duration: 0.5,
                        options: [customOptions],
                        animations: nil,
                        completion: nil
                    )
                }
        window.rootViewController = viewController
    }
}
