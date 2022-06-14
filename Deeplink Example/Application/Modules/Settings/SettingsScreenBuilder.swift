//
//  SettingsScreenBuilder.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 12.06.2022.
//

import UIKit

protocol SettingsScreenBuilderProtocol: AnyObject {
    func buildSettingsList(output: SettingsOutput) -> UIViewController
    func buildSettingsItem(_ item: SettingsItem) -> UIViewController
}

final class SettingsScreenBuilder: SettingsScreenBuilderProtocol {
    
    func buildSettingsList(output: SettingsOutput) -> UIViewController {
        let presenter = SettingsPresenter(output: output)
        let view = SettingsViewController(presenter: presenter)
        presenter.viewDelegate = view
        view.title = "Settings"
        return view
    }
    
    func buildSettingsItem(_ item: SettingsItem) -> UIViewController {
        let view = SettingsItemViewController(settingItem: item)
        return view
    }
}
