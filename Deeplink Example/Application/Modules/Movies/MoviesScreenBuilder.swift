//
//  MainScreenBuilder.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import UIKit

protocol MoviesScreenBuilderProtocol: AnyObject {
    func buildMoviesList(output: MoviesListOutput) -> UIViewController
    func buildMovie(by id: Int, output: MovieOutput) -> UIViewController
    func buildActorsList(byMovie id: Int, output: ActorsListOutput) -> UIViewController
    func buildActor(by id: Int, output: ActorOutput) -> UIViewController
}

final class MoviesScreenBuilder: MoviesScreenBuilderProtocol {
    func buildMoviesList(output: MoviesListOutput) -> UIViewController {
        let moviesFetchService = MoviesFetchService()
        let presenter = MoviesListPresenter(moviesFetchService: moviesFetchService, output: output)
        let view = MoviesListViewController(presenter: presenter)
        view.title = "Movies list"
        presenter.viewDelegate = view
        return view
    }
    
    func buildMovie(by id: Int, output: MovieOutput) -> UIViewController {
        let moviesFetchService = MoviesFetchService()
        let presenter = MoviePresenter(movieId: id, moviesFetchService: moviesFetchService, output: output)
        let view = MovieViewController(presenter: presenter)
        view.title = "Movie"
        presenter.viewDelegate = view
        return view
    }
    
    func buildActorsList(byMovie id: Int, output: ActorsListOutput) -> UIViewController {
        let actorsFetchService = ActorsFetchService()
        let presenter = ActorsListPresenter(movieId: id, actorsFetchService: actorsFetchService, output: output)
        let view = ActorsListViewController(presenter: presenter)
        view.title = "Actors list"
        presenter.viewDelegate = view
        return view
    }
    
    func buildActor(by id: Int, output: ActorOutput) -> UIViewController {
        let actorsFetchService = ActorsFetchService()
        let presenter = ActorPresenter(actorId: id, actorsFetchService: actorsFetchService, output: output)
        let view = ActorViewController(presenter: presenter)
        view.title = "Actor"
        presenter.viewDelegate = view
        return view
    }
}
