//
//  MainSceneDelegate.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import UIKit

final class MainSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Properties
    
    var applicationCoordinator: ApplicationCoordinatorProtocol?
    var window: UIWindow?

    // MARK: - UIWindowSceneDelegate
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let applicationCoordinator = ApplicationCoordinator(window: window)
        self.applicationCoordinator = applicationCoordinator
        applicationCoordinator.start(animated: true, completion: nil)
        
        let userActivityPath = connectionOptions.userActivities.first?.webpageURL?.path
        let urlContextPath = connectionOptions.urlContexts.first?.url.path
        findFirstResponderIfNeeded(of: userActivityPath ?? urlContextPath)
    }
    
    func scene(_ scene: UIScene, openURLContexts urlContexts: Set<UIOpenURLContext>) {
        findFirstResponderIfNeeded(of: urlContexts.first?.url.path)
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        findFirstResponderIfNeeded(of: userActivity.webpageURL?.path)
    }
    
    // MARK: - Deeplink
    
    func findFirstResponderIfNeeded(of deeplinkPath: String?) {
        guard let path = deeplinkPath else { return }
        applicationCoordinator?.start(deeplink: path)
    }
}
