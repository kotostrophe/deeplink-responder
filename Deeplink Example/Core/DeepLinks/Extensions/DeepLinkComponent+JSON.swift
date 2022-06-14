// DeepLinkComponent+JSON.swift
// Copyright © Selecto. All rights reserved.

import Foundation
import SwiftyJSON

extension JSON {
    subscript<Component>(key: Component) -> JSON
        where Component: RawRepresentable, Component.RawValue == String
    { self[key.rawValue] }
}
