//
//  ApplicationCoordinator.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import UIKit

protocol ApplicationCoordinatorProtocol: Coordinatable, DeepLinkResponder {
    
}

final class ApplicationCoordinator: ApplicationCoordinatorProtocol {
    
    // MARK: - Public properties
    
    unowned var window: UIWindow
    
    var rootViewController: UIViewController? { window.rootViewController }
    var deepLinkLocator: DeepLinkLocatorProtocol = DeepLinkLocator()
    var childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
    var parent: Coordinatable?
    
    // MARK: - Initializers
    
    init(window: UIWindow) {
        self.window = window
    }
    
    convenience init(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        self.init(window: window)
    }
    
    // MARK: - Methods
    
    func start(animated: Bool, completion: (() -> Void)?) {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.parent = self
        childLocator.push(coordiantor: mainCoordinator, by: "main")
        mainCoordinator.start(animated: animated, completion: nil)
        
        window.rootViewController = mainCoordinator.rootViewController
        window.makeKeyAndVisible()
        completion?()
    }
}
