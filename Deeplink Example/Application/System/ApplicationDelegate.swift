//
//  AppDelegate.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import UIKit

let deeplinkScheme = "deep"

@main
final class ApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Life cycle methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard url.scheme?.compare(deeplinkScheme) == .orderedSame else { return true }
        handle(deeplink: url, of: application)
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // MARK: - Deeplink methods
    
    func handle(
        deeplink: URL,
        of application: UIApplication
    ) {
        guard let mainScene = fetchMainSceneDelegate(from: application) else { return }
        mainScene.findFirstResponderIfNeeded(of: deeplink.path)
    }
    
    // MARK: - Private methods
    
    private func fetchMainSceneDelegate(from application: UIApplication) -> MainSceneDelegate? {
        application.connectedScenes.compactMap({ $0.delegate as? MainSceneDelegate }).first
    }
}

