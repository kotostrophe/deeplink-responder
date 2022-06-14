//
//  SettingsItem.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 12.06.2022.
//

import Foundation
import UIKit

enum SettingsItem {
    case wifi, bluetooth, general, accessibility, privacy, battery
    
    var title: String {
        switch self {
        case .wifi: return "WiFi"
        case .bluetooth: return "Bluetooth"
        case .general: return "General"
        case .accessibility: return "Accessibility"
        case .privacy: return "Privacy"
        case .battery: return "Battery"
        }
    }
    
    var imageData: Data? {
        switch self {
        case .wifi: return UIImage(systemName: "wifi")?.pngData()
        case .bluetooth: return UIImage(systemName: "dot.radiowaves.left.and.right")?.pngData()
        case .general: return UIImage(systemName: "wrench.and.screwdriver.fill")?.pngData()
        case .accessibility: return UIImage(systemName: "figure.wave.circle.fill")?.pngData()
        case .privacy: return UIImage(systemName: "hand.raised.fill")?.pngData()
        case .battery: return UIImage(systemName: "battery.100")?.pngData()
        }
    }
}
