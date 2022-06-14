//
//  Coordinatable.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import UIKit

protocol Coordinatable: AnyObject {
    var rootViewController: UIViewController? { get }
    var childLocator: CoordinatorLocatorProtocol { get }
    var parent: Coordinatable? { get }

    func start(animated: Bool, completion: (() -> Void)?)
    func start(coordinator: Coordinatable, animated: Bool, completion: (() -> Void)?)
}

extension Coordinatable {
    func start(coordinator: Coordinatable, animated: Bool = true, completion: (() -> Void)? = nil) {
        coordinator.start(animated: animated, completion: completion)
    }
}
