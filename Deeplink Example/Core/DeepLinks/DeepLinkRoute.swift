// DeepLinkRoute.swift
// Copyright © Selecto. All rights reserved.

import Foundation
import SwiftyJSON

final class DeepLinkRoute {
    static let separator = "/"
    static let variable = ":"

    typealias RouteAction = (JSON) -> Void

    // MARK: - Properties

    let path: String
    let action: RouteAction

    // MARK: - Initializers

    init(path: String, action: @escaping RouteAction) {
        self.path = DeepLinkRoute.separator + path
        self.action = action
    }

    // MARK: - Methods

    func prepareAction(with path: String) -> (() -> Void) {
        let json = DeepLinkRoute.parse(path: path, with: self)
        return { [weak self] in
            guard let self = self else { return }
            self.action(json)
        }
    }
}

// MARK: - Equatable

extension DeepLinkRoute: Equatable {
    static func == (lhs: String, rhs: DeepLinkRoute) -> Bool {
        let path = lhs.components(separatedBy: separator).filter(\.isNotEmpty)
        let targetPath = rhs.path.components(separatedBy: separator).filter(\.isNotEmpty)
        guard path.count == targetPath.count else { return false }
        return zip(path, targetPath).allSatisfy { path, targetPath in
            switch targetPath.hasPrefix(variable) {
            case true: return true
            case false: return path == targetPath
            }
        }
    }

    static func == (lhs: DeepLinkRoute, rhs: DeepLinkRoute) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

// MARK: - Hashable

extension DeepLinkRoute: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }
}

extension DeepLinkRoute {
    static func parse(path: String, with route: DeepLinkRoute) -> JSON {
        let path = path.components(separatedBy: separator).filter(\.isNotEmpty)
        let targetPath = route.path.components(separatedBy: separator).filter(\.isNotEmpty)
        guard path.count == targetPath.count else { return .init() }
        return zip(path, targetPath)
            .map({ (path: $0.0, targetPath: $0.1) })
            .reduce(into: JSON()) { container, components in
                let value = components.path
                let routeElement = components.targetPath
                guard routeElement.hasPrefix(variable) else { return }
                let key = routeElement.replacingOccurrences(of: variable, with: "")
                container[key] = JSON(value)
            }
    }
}
