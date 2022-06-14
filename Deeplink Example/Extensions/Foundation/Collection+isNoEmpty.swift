//
//  Collection+isEmpty.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation

extension Collection {
    @inlinable var isNotEmpty: Bool { isEmpty == false }
}

extension Optional where Wrapped: Collection {
    @inlinable var isEmpty: Bool {
        switch self {
        case let .some(collection): return collection.isEmpty
        case .none: return true
        }
    }

    @inlinable var isNotEmpty: Bool { !isEmpty }
}
