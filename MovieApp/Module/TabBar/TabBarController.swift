//
//  TabbarController.swift
//  MovieApp
//
//  Created by Halil Bakar on 23.08.2023.
//

import UIKit

protocol TabBarControllerProtocol: AnyObject {
    func configureTabBar()
    func configureNavBar()
    func setTabBarControllers()
}

final class TabBarController: UITabBarController {

    private let homeModule = HomeRouter.startExecution()
    private let moviesModule = MoviesRouter.startExecution()
    private let profileModule = ProfileRouter.startExecution()
    private let favoritesModule = FavoritesRouter.startExecution()
    
    internal var presenter: TabBarPresenterInputs!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()        
    }
}

extension TabBarController: TabBarControllerProtocol {
    func configureTabBar() {
        tabBar.backgroundColor = .systemGray5
        tabBar.tintColor = .label
        tabBar.layer.shadowOpacity = 0.75
        tabBar.layer.cornerRadius = 8
        tabBar.layer.shadowColor = UIColor.systemGray.cgColor
    }
    
    func configureNavBar() {
        navigationItem.hidesBackButton = true
    }
    
    func setTabBarControllers() {
        setViewControllers(
            [
                setController(viewController: homeModule,
                              title: "Home",
                              imageName: "house",
                              selectedImageName: "house.fill"),
                
                setController(viewController: moviesModule,
                              title: "Movies",
                              imageName: "popcorn",
                              selectedImageName: "popcorn"),
                
                setController(viewController: favoritesModule,
                              title: "Favorites",
                              imageName: "heart",
                              selectedImageName: "heart"),
                
                setController(viewController: profileModule,
                              title: "Profile",
                              imageName: "person",
                              selectedImageName: "person.fill"),
            ],
                           animated: true)
    }
}

