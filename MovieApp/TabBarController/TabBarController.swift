//
//  TabbarController.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: MoviesViewController())
        let vc3 = UINavigationController(rootViewController: ProfileViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "person.fill")
        
        vc1.title = "Home"
        vc2.title = "Movies"
        vc3.title = "Profile"
        
        tabBar.tintColor = .white
        setViewControllers([vc1,vc2,vc3], animated: true)
    }
}

