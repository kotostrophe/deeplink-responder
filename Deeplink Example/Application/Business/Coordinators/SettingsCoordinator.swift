//
//  SettingsCoordinator.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 12.06.2022.
//

import UIKit
import CoordinatorKit
import DeepCoordinatorKit

protocol SettingsCoordinatorProtocol: Coordinatable, DeepLinkResponder {
    func startSettingsItem(_ item: SettingsItem, animated: Bool)
}

final class SettingsCoordinator: SettingsCoordinatorProtocol {
    
    // MARK: - Public properties
    
    var rootViewController: UIViewController? { navigationController }
    var deepLinkLocator: DeepLinkLocatorProtocol = DeepLinkLocator()
    var childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
    var parent: Coordinatable?
    
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    private let settingsScreenBuilder: SettingsScreenBuilderProtocol = SettingsScreenBuilder()
    
    // MARK: - Initializers
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        
        deepLinkLocator.add(routes: [
            makeWifiHandler(),
            makeBluetoothHandler()
        ])
    }
    
    convenience init() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        self.init(navigationController: navigationController)
    }
    
    // MARK: - Methods
    
    func start(animated: Bool) {
        let view = settingsScreenBuilder.buildSettingsList(output: self)
        navigationController.pushViewController(view, animated: animated)
    }
    
    func startSettingsItem(_ item: SettingsItem, animated: Bool) {
        let view = settingsScreenBuilder.buildSettingsItem(item)
        navigationController.pushViewController(view, animated: animated)
    }
    
    func finish(animated: Bool) {
        childLocator.popAll()
    }
}

// MARK: - SettingsOutput

extension SettingsCoordinator: SettingsOutput {
    
    func setting(_ presenter: SettingsPresenterProtocol, didSelectSettingItem item: SettingsItem) {
        startSettingsItem(item, animated: true)
    }
}

// MARK: - Deeplink handler factory

extension SettingsCoordinator {
    
    func makeWifiHandler() -> DeepLinkRoute {
        .init(path: "settings" / "wifi") { [weak self] json in
            self?.startSettingsItem(.wifi, animated: true)
        }
    }
    
    func makeBluetoothHandler() -> DeepLinkRoute {
        .init(path: "settings" / "bluetooth") { [weak self] json in
            self?.startSettingsItem(.bluetooth, animated: true)
        }
    }
}
