// DeepLinkLocator.swift
// Copyright © Selecto. All rights reserved.

import Foundation

protocol DeepLinkLocatorProtocol: AnyObject {
    var routes: Set<DeepLinkRoute> { get }

    func add(route: DeepLinkRoute)
    func add(routes: [DeepLinkRoute])
    func add(routes: DeepLinkRoute...)
    func remove(route: DeepLinkRoute)
    func get(routeBy path: String) -> DeepLinkRoute?
    func remove(routeBy path: String)
}

final class DeepLinkLocator: DeepLinkLocatorProtocol {
    // MARK: - Properties

    var routes: Set<DeepLinkRoute>

    // MARK: - Initializers

    init(routes: Set<DeepLinkRoute> = []) {
        self.routes = routes
    }

    // MARK: - Methods

    func add(route: DeepLinkRoute) {
        routes.insert(route)
    }

    func add(routes: [DeepLinkRoute]) {
        routes.forEach(add(route:))
    }

    func add(routes: DeepLinkRoute...) {
        routes.forEach(add(route:))
    }

    func remove(route: DeepLinkRoute) {
        routes.remove(route)
    }

    func get(routeBy path: String) -> DeepLinkRoute? {
        routes.first { $0.path == path }
    }

    func remove(routeBy path: String) {
        guard let route = get(routeBy: path) else { return }
        routes.remove(route)
    }
}
