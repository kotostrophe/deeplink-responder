//
//  MovieViewController.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation
import UIKit

protocol MovieViewProtocol: AnyObject {
    func setMovieData(_ movie: Movie)
}

final class MovieViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var yearOfPublishingLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    private let presenter: MoviePresenterProtocol
    
    // MARK: - Initializers
    
    init(presenter: MoviePresenterProtocol) {
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
        
        presenter.loadData()
    }
    
    // MARK: - Configuration methods
    
    private func configureImageView(with data: Data?) {
        guard let data = data else { return }
        imageView.image = .init(data: data)
    }
    
    private func configureTitle(with text: String) {
        titleLabel.text = text
    }
    
    private func configureDescription(with text: String) {
        descriptionLabel.text = text
    }
    
    private func configureRating(with value: Float) {
        ratingLabel.text = String(format: "%.1f / %.1f", value, 100.0)
    }
    
    private func configureYearOfPublishing(with value: String) {
        yearOfPublishingLabel.text = value
    }
    
    // MARK: - IBActions
    
    @IBAction private func didSelectActorsAction() {
        presenter.didSelectActors()
    }
}

// MARK: - MovieViewProtocol

extension MovieViewController: MovieViewProtocol {
    func setMovieData(_ movie: Movie) {
        configureImageView(with: movie.imageData)
        configureTitle(with: movie.title)
        configureDescription(with: movie.description)
        configureRating(with: movie.rating)
        configureYearOfPublishing(with: movie.yearOfPublishing)
    }
}
