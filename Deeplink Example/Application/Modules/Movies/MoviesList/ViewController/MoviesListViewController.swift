//
//  MoviesListViewController.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation
import UIKit

protocol MoviesListViewProtocol: AnyObject {
    func reloadData()
}

final class MoviesListViewController: UIViewController {
    
    // MARK: - IBOutlet properties
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    
    private let presenter: MoviesListPresenterProtocol
    
    // MARK: - Initializers
    
    init(presenter: MoviesListPresenterProtocol) {
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "movieCell")
    }
}

// MARK: - ColorViewProtocol

extension MoviesListViewController: MoviesListViewProtocol {
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension MoviesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.didSelectMovie(by: indexPath.item)
    }
}

// MARK: - UITableViewDataSource

extension MoviesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = presenter.movies[indexPath.item]
        let configuration = makeConfiguration(of: movie)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.contentConfiguration = configuration
        return cell
    }
}

// MARK: - Private factory methods

extension MoviesListViewController {
    func makeConfiguration(of movie: Movie) -> UIListContentConfiguration {
        var contentConfiguration = UIListContentConfiguration.subtitleCell()
        contentConfiguration.text = movie.title
        contentConfiguration.textProperties.color = .label
        contentConfiguration.secondaryText = movie.yearOfPublishing
        contentConfiguration.secondaryTextProperties.color = .secondaryLabel
        contentConfiguration.image = {
            guard let data = movie.imageData else { return nil }
            return UIImage(data: data)
        }()
        contentConfiguration.imageProperties.maximumSize = .init(width: 52, height: 52)
        contentConfiguration.imageProperties.cornerRadius = 4
        contentConfiguration.imageProperties.reservedLayoutSize = .init(width: 52, height: 52)
        return contentConfiguration
    }
}


