//
//  ColorPresenter.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation

protocol MoviesListOutput: AnyObject {
    func moviesList(_ presenter: MoviesListPresenterProtocol, didSelectMovieWith id: Int)
}

protocol MoviesListPresenterProtocol: AnyObject {
    var movies: [Movie] { get }
    
    func loadData()
    func didSelectMovie(by index: Int)
}

final class MoviesListPresenter: MoviesListPresenterProtocol {
    
    // MARK: - Properties
    
    var movies: [Movie] = []
    
    private let moviesFetchService: MoviesFetchServiceProtocol
    private weak var output: MoviesListOutput?
    
    weak var viewDelegate: MoviesListViewProtocol?
    
    // MARK: - Initializers
    
    init(
        moviesFetchService: MoviesFetchServiceProtocol,
        output: MoviesListOutput?
    ) {
        self.moviesFetchService = moviesFetchService
        self.output = output
    }
    
    // MARK: - Methods
    
    func loadData() {
        movies = moviesFetchService.fetchMovies()
        viewDelegate?.reloadData()
    }
    
    func didSelectMovie(by index: Int) {
        let movie = movies[index]
        output?.moviesList(self, didSelectMovieWith: movie.id)
    }
}
