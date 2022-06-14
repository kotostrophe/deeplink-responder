// DeepLinkComponent+String.swift
// Copyright © Selecto. All rights reserved.

import Foundation

func / (lhs: String, rhs: String) -> String {
    [lhs, rhs]
        .joined(separator: DeepLinkRoute.separator)
}

func / <Component>(lhs: String, rhs: Component) -> String
    where Component: RawRepresentable, Component.RawValue == String
{
    [lhs, DeepLinkRoute.variable + rhs.rawValue]
        .joined(separator: DeepLinkRoute.separator)
}

func / <Component>(lhs: Component, rhs: String) -> String
    where Component: RawRepresentable, Component.RawValue == String
{
    [DeepLinkRoute.variable + lhs.rawValue, rhs]
        .joined(separator: DeepLinkRoute.separator)
}

func / <Component>(lhs: Component, rhs: Component) -> String
    where Component: RawRepresentable, Component.RawValue == String
{
    [DeepLinkRoute.variable + lhs.rawValue, DeepLinkRoute.variable + rhs.rawValue]
        .joined(separator: DeepLinkRoute.separator)
}
