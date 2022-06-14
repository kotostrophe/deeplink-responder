//
//  MoviePresenter.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation

protocol MovieOutput: AnyObject {
    func movie(_ presenter: MoviePresenterProtocol, didSelectActorsListBy id: Int)
    func movie(_ presenter: MoviePresenterProtocol, didNotFindMovieBy id: Int)
}

protocol MoviePresenterProtocol: AnyObject {
    func loadData()
    func didSelectActors()
}

final class MoviePresenter: MoviePresenterProtocol {
    
    // MARK: - Properties
    
    var movie: Movie?
    
    weak var viewDelegate: MovieViewProtocol?
    
    // MARK: - Private properties
    
    private let movieId: Int
    private let moviesFetchService: MoviesFetchServiceProtocol
    
    private weak var output: MovieOutput?
    
    // MARK: - Initializers
    
    init(
        movieId: Int,
        moviesFetchService: MoviesFetchServiceProtocol,
        output: MovieOutput
    ) {
        self.movieId = movieId
        self.moviesFetchService = moviesFetchService
        self.output = output
    }
    
    // MARK: - Methods
    
    func loadData() {
        switch moviesFetchService.fetchMovie(movieId: movieId) {
        case let .some(movie):
            self.movie = movie
            viewDelegate?.setMovieData(movie)
            
        case .none:
            output?.movie(self, didNotFindMovieBy: movieId)
        }
        
    }
    
    func didSelectActors() {
        output?.movie(self, didSelectActorsListBy: movieId)
    }
}
