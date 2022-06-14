//
//  MainCoordinator.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import UIKit

protocol MainCoordinatorProtocol: Coordinatable, DeepLinkResponder {
    
}

final class MainCoordinator: MainCoordinatorProtocol {
    
    // MARK: - Public properties
    
    var rootViewController: UIViewController? { tabBarController }
    var deepLinkLocator: DeepLinkLocatorProtocol = DeepLinkLocator()
    var childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
    var parent: Coordinatable?
    
    // MARK: - Private properties
    
    private let tabBarController: UITabBarController
    
    // MARK: - Initializers
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    convenience init() {
        let tabBarController = UITabBarController()
        self.init(tabBarController: tabBarController)
    }
    
    // MARK: - Methods
    
    func start(animated: Bool, completion: (() -> Void)?) {
        let moviesViewController: UIViewController = {
            let moviesNavigationController = UINavigationController()
            moviesNavigationController.navigationBar.prefersLargeTitles = true
            moviesNavigationController.tabBarItem = .init(
                title: "Movies",
                image: .init(systemName: "list.bullet.rectangle.portrait"),
                selectedImage: .init(systemName: "list.bullet.rectangle.portrait.fill")
            )
            let moviesCoordinator = MoviesCoordinator(navigationController: moviesNavigationController)
            moviesCoordinator.parent = self
            childLocator.push(coordiantor: moviesCoordinator, by: "movies.list")
            moviesCoordinator.start(animated: animated, completion: nil)
            return moviesNavigationController
        }()
        
        let settingsViewController: UIViewController = {
            let settingsNavigationController = UINavigationController()
            settingsNavigationController.navigationBar.prefersLargeTitles = true
            settingsNavigationController.tabBarItem = .init(
                title: "Settings",
                image: .init(systemName: "gearshape"),
                selectedImage: .init(systemName: "gearshape.fill")
            )
            let settingsCoordinator = SettingsCoordinator(navigationController: settingsNavigationController)
            settingsCoordinator.parent = self
            childLocator.push(coordiantor: settingsCoordinator, by: "settings.list")
            settingsCoordinator.start(animated: animated, completion: nil)
            return settingsNavigationController
        }()
        
        tabBarController.viewControllers = [
            moviesViewController,
            settingsViewController
        ]
        completion?()
    }
    
}
