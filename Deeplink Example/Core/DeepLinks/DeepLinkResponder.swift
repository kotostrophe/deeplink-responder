// DeepLinkResponder.swift
// Copyright © Selecto. All rights reserved.

import Foundation
import UIKit

protocol DeepLinkResponder: AnyObject {
    var deepLinkLocator: DeepLinkLocatorProtocol { get }

    func becomeFirstResponder(child: Coordinatable?)
    func canRespond(on path: String) -> Bool
    func respond(on path: String)
    func hitTest(with path: String) -> DeepLinkResponder?
}

extension DeepLinkResponder {
    func respond(on deepLink: String) {}
}

// MARK: - DeepLinkResponder

extension Coordinatable where Self: DeepLinkResponder {
    func becomeFirstResponder(child: Coordinatable? = nil) {
        switch rootViewController {
        case let tabBarController as UITabBarController:
            guard
                let childViewController = child?.rootViewController,
                let index = tabBarController.viewControllers?.firstIndex(of: childViewController)
            else { break }
            tabBarController.selectedIndex = index
        default: break
        }

        guard let parent = parent as? DeepLinkResponder else { return }
        parent.becomeFirstResponder(child: self)
    }

    func respond(on path: String) {
        deepLinkLocator.routes
            .first(where: { route in path == route })?
            .prepareAction(with: path)()
    }

    func canRespond(on path: String) -> Bool {
        deepLinkLocator.routes.contains(where: { route in path == route })
    }

    func hitTest(with path: String) -> DeepLinkResponder? {
        if canRespond(on: path) { return self }
        for targetResponder in childLocator.coordiantors.compactMap({ $0 as? DeepLinkResponder }) {
            guard let targetResponder = targetResponder.hitTest(with: path) else { continue }
            return targetResponder
        }
        return nil
    }
}
