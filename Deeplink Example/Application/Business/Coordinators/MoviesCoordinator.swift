//
//  MoviesCoordinator.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import UIKit
import CoordinatorKit
import DeepCoordinatorKit

protocol MoviesCoordinatorProtocol: Coordinatable, DeepLinkResponder {
    func startMoviesList(animated: Bool)
    func startMovie(by id: Int, animated: Bool)
    func startActors(byMovie id: Int, animated: Bool)
    func startActor(by id: Int, animated: Bool)
}

final class MoviesCoordinator: MoviesCoordinatorProtocol {
    
    // MARK: - Public properties
    
    var rootViewController: UIViewController? { navigationController }
    var deepLinkLocator: DeepLinkLocatorProtocol = DeepLinkLocator()
    var childLocator: CoordinatorLocatorProtocol = CoordinatorLocator()
    var parent: Coordinatable?
    
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    private let moviesScreenBuilder: MoviesScreenBuilderProtocol = MoviesScreenBuilder()
    
    // MARK: - Initializers
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        
        deepLinkLocator.add(routes: [
            makeMoviesListHandler(),
            makeMovieHandler(),
            makeActorsListOfMovieHandler(),
            makeActorHandler()
        ])
    }
    
    convenience init() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        self.init(navigationController: navigationController)
    }
    
    // MARK: - Methods
    
    func start(animated: Bool) {
        startMoviesList(animated: animated)
    }
    
    func startMoviesList(animated: Bool) {
        let view = moviesScreenBuilder.buildMoviesList(output: self)
        navigationController.pushViewController(view, animated: animated)
    }
    
    func startMovie(by id: Int, animated: Bool) {
        let view = moviesScreenBuilder.buildMovie(by: id, output: self)
        navigationController.pushViewController(view, animated: animated)
    }
    
    func startActors(byMovie id: Int, animated: Bool) {
        let view = moviesScreenBuilder.buildActorsList(byMovie: id, output: self)
        navigationController.pushViewController(view, animated: animated)
    }
    
    func startActor(by id: Int, animated: Bool) {
        let view = moviesScreenBuilder.buildActor(by: id, output: self)
        navigationController.pushViewController(view, animated: animated)
    }
    
    func popBack() {
        navigationController.popViewController(animated: true)
    }
    
    func finish(animated: Bool) {
        childLocator.popAll()
    }
}

// MARK: - MoviesListOutput

extension MoviesCoordinator: MoviesListOutput {
    
    func moviesList(_ presenter: MoviesListPresenterProtocol, didSelectMovieWith id: Int) {
        startMovie(by: id, animated: true)
    }
}

// MARK: - MovieOutput

extension MoviesCoordinator: MovieOutput {
    func movie(_ presenter: MoviePresenterProtocol, didSelectActorsListBy id: Int) {
        startActors(byMovie: id, animated: true)
    }
    
    func movie(_ presenter: MoviePresenterProtocol, didNotFindMovieBy id: Int) {
        popBack()
    }
}

// MARK: - ActorsListOutput

extension MoviesCoordinator: ActorsListOutput {
    func actorsList(_ presenter: ActorsListPresenterProtocol, didSelectActorWith id: Int) {
        startActor(by: id, animated: true)
    }
}

// MARK: - ActorOutput

extension MoviesCoordinator: ActorOutput {
    func actor(_ presenter: ActorPresenterProtocol, didNotFindActorBy id: Int) {
        popBack()
    }
}

// MARK: - Deeplink handler factory

extension MoviesCoordinator {
    
    enum PathComponents: String {
        case movieId, actorId
    }
    
    func makeMoviesListHandler() -> DeepLinkRoute {
        .init(path: "movies") { [weak self] _ in
            self?.startMoviesList(animated: true)
        }
    }
    
    func makeMovieHandler() -> DeepLinkRoute {
        .init(path: "movies" / PathComponents.movieId) { [weak self] json in
            let movieId = json[PathComponents.movieId].intValue
            self?.startMovie(by: movieId, animated: true)
        }
    }
    
    func makeActorsListOfMovieHandler() -> DeepLinkRoute {
        .init(path: "movies" / PathComponents.movieId / "actors") { [weak self] json in
            let movieId = json[PathComponents.movieId].intValue
            self?.startMovie(by: movieId, animated: false)
            self?.startActors(byMovie: movieId, animated: true)
        }
    }
    
    func makeActorHandler() -> DeepLinkRoute {
        .init(path: "actors" / PathComponents.actorId) { [weak self] json in
            let actorId = json[PathComponents.actorId].intValue
            self?.startActor(by: actorId, animated: true)
        }
    }
}
