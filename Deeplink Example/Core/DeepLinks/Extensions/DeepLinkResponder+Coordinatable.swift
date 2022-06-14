//
//  DeepLinkResponder+Coordinatable.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation
import UIKit

extension Coordinatable where Self: DeepLinkResponder {
    
    func start(
        deeplink path: String,
        on queue: DispatchQueue = .global(qos: .background)
    ) {
        start(deeplink: path, from: self, on: queue)
    }
    
    func start<Responder>(
        deeplink path: String,
        from responder: Responder,
        on queue: DispatchQueue = .global(qos: .background)
    ) where Responder: Coordinatable & DeepLinkResponder {
        queue.async {
            guard let firstResponder = responder.hitTest(with: path) else { return }
            DispatchQueue.main.async {
                firstResponder.becomeFirstResponder(child: nil)
                firstResponder.respond(on: path)
            }
        }
    }
}
