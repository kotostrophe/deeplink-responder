//
//  SettingsViewController.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 12.06.2022.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    
}

final class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlet properties
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    
    private let presenter: SettingsPresenterProtocol
    
    // MARK: - Initializers
    
    init(presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        presenter.loadData()
    }
    
    // MARK: - Configuration methods
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingsCell")
    }
}

// MARK: - SettingsViewProtocol

extension SettingsViewController: SettingsViewProtocol {
    
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.didSelectItem(by: indexPath.item, in: indexPath.section)
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsItem = presenter.items[indexPath.section][indexPath.row]
        let configuration = makeConfiguration(of: settingsItem)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.contentConfiguration = configuration
        return cell
    }
}

// MARK: - Private factory methods

extension SettingsViewController {
    func makeConfiguration(of item: SettingsItem) -> UIListContentConfiguration {
        var contentConfiguration = UIListContentConfiguration.cell()
        contentConfiguration.text = item.title
        contentConfiguration.textProperties.color = .label
        contentConfiguration.image = {
            guard let data = item.imageData else { return nil }
            return UIImage(data: data)?.withRenderingMode(.alwaysTemplate)
        }()
        contentConfiguration.imageProperties.maximumSize = .init(width: 24, height: 24)
        contentConfiguration.imageProperties.reservedLayoutSize = .init(width: 24, height: 24)
        contentConfiguration.imageProperties.cornerRadius = 4
        contentConfiguration.imageProperties.tintColor = .label
        return contentConfiguration
    }
}


