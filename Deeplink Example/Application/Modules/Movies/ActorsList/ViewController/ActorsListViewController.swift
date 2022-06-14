//
//  ActorsListViewController.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation
import UIKit

protocol ActorsListViewProtocol: AnyObject {
    func reloadData()
}

final class ActorsListViewController: UIViewController {
    
    // MARK: - IBOutlet properties
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    
    private let presenter: ActorsListPresenterProtocol
    
    // MARK: - Initializers
    
    init(presenter: ActorsListPresenterProtocol) {
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
    
    // MARK: - Private methods
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "actorCell")
    }
}

// MARK: - ColorViewProtocol

extension ActorsListViewController: ActorsListViewProtocol {
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ActorsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.didSelectActor(by: indexPath.item)
    }
}

// MARK: - UITableViewDataSource

extension ActorsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.actors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let actor = presenter.actors[indexPath.item]
        let configuration = makeConfiguration(of: actor)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.contentConfiguration = configuration
        return cell
    }
}

// MARK: - Private factory methods

extension ActorsListViewController {
    func makeConfiguration(of actor: Actor) -> UIListContentConfiguration {
        var contentConfiguration = UIListContentConfiguration.cell()
        contentConfiguration.text = actor.name
        contentConfiguration.textProperties.color = .label
        contentConfiguration.secondaryTextProperties.color = .secondaryLabel
        contentConfiguration.image = {
            guard let data = actor.imageData else { return nil }
            return UIImage(data: data)
        }()
        contentConfiguration.imageProperties.maximumSize = .init(width: 52, height: 52)
        contentConfiguration.imageProperties.cornerRadius = 4
        contentConfiguration.imageProperties.reservedLayoutSize = .init(width: 52, height: 52)
        return contentConfiguration
    }
}


