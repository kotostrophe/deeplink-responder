//
//  SettingsPresenter.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 12.06.2022.
//

import Foundation

protocol SettingsOutput: AnyObject {
    func setting(_ presenter: SettingsPresenterProtocol, didSelectSettingItem item: SettingsItem)
}

protocol SettingsPresenterProtocol: AnyObject {
    var items: [[SettingsItem]] { get }
    
    func loadData()
    func didSelectItem(by index: Int, in section: Int)
}

final class SettingsPresenter: SettingsPresenterProtocol {
    
    // MARK: - Properties
    
    var items: [[SettingsItem]] = [
        [.wifi, .bluetooth],
        [.general, .accessibility, .privacy, .battery]
    ]
    
    weak var viewDelegate: SettingsViewProtocol?
    
    // MARK: - Private properties
    
    private weak var output: SettingsOutput?
    
    // MARK: - Initializers
    
    init(
        output: SettingsOutput
    ) {
        self.output = output
    }
    
    // MARK: - Methods
    
    func loadData() { }
    
    func didSelectItem(by index: Int, in section: Int) {
        let item = items[section][index]
        output?.setting(self, didSelectSettingItem: item)
    }
}
