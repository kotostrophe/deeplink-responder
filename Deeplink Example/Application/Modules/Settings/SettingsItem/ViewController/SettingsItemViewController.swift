//
//  SettingsItemViewController.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 12.06.2022.
//

import UIKit

final class SettingsItemViewController: UIViewController {
    
    // MARK: - IBOutlet properties
    
    @IBOutlet private var titleLabel: UILabel!
    
    // MARK: - Properties
    
    private let settingItem: SettingsItem
    
    // MARK: - Initializers
    
    init(settingItem: SettingsItem) {
        self.settingItem = settingItem
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabel()
    }
    
    // MARK: - Configuration methods
    
    private func configureLabel() {
        titleLabel.text = settingItem.title
    }
}
