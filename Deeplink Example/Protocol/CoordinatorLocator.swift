//
//  CoordinatorLocator.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation

typealias CoordinatorTypeKey = String
typealias CoordinatorType = (key: CoordinatorTypeKey, value: Coordinatable)

protocol CoordinatorLocatorProtocol: AnyObject {
    var coordiantors: [Coordinatable] { get }

    func key(of coordinator: Coordinatable) -> CoordinatorTypeKey?
    func push(coordiantor: Coordinatable, by key: CoordinatorTypeKey)
    func replace(coordiantor: Coordinatable, by key: CoordinatorTypeKey)
    func pop()
    func remove(coordinatorBy key: CoordinatorTypeKey)

    subscript(key: CoordinatorTypeKey) -> Coordinatable? { get }
}

final class CoordinatorLocator: CoordinatorLocatorProtocol {
    // MARK: - Properties

    private var keyedCoordiantors: [CoordinatorType] = []
    var coordiantors: [Coordinatable] { keyedCoordiantors.map(\.value) }

    // MARK: - Initializers

    init() {}

    // MARK: - Methods

    func key(of coordinator: Coordinatable) -> CoordinatorTypeKey? {
        keyedCoordiantors.first { $0.value === coordinator }?.key
    }

    func push(coordiantor: Coordinatable, by key: CoordinatorTypeKey) {
        guard !keyedCoordiantors.contains(where: { $0.key == key }) else { return }
        keyedCoordiantors.append((key, coordiantor))
    }

    func replace(coordiantor: Coordinatable, by key: CoordinatorTypeKey) {
        remove(coordinatorBy: key)
        push(coordiantor: coordiantor, by: key)
    }

    func pop() {
        keyedCoordiantors.removeLast()
    }

    func remove(coordinatorBy key: CoordinatorTypeKey) {
        guard let targetIndex = keyedCoordiantors.firstIndex(where: { $0.key == key }) else { return }
        let index = keyedCoordiantors.startIndex.distance(to: targetIndex)
        keyedCoordiantors.remove(at: index)
    }
}

extension CoordinatorLocator {
    subscript(key: CoordinatorTypeKey) -> Coordinatable? {
        keyedCoordiantors.first { $0.key == key }?.value
    }
}
