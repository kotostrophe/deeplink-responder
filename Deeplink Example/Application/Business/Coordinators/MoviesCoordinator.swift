//
//  MoviesCoordinator.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation
import UIKit

protocol MoviesCoordinatorProtocol: Coordinatable, DeepLinkResponder {
    func startMoviesList(animated: Bool, completion: (() -> Void)?)
    func startMovie(by id: Int, animated: Bool, completion: (() -> Void)?)
    func startActors(byMovie id: Int, animated: Bool, completion: (() -> Void)?)
    func startActor(by id: Int, animated: Bool, completion: (() -> Void)?)
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
    
    func start(animated: Bool, completion: (() -> Void)?) {
        startMoviesList(animated: animated, completion: completion)
    }
    
    func startMoviesList(animated: Bool, completion: (() -> Void)?) {
        let view = moviesScreenBuilder.buildMoviesList(output: self)
        navigationController.pushViewController(view, animated: animated)
        completion?()
    }
    
    func startMovie(by id: Int, animated: Bool, completion: (() -> Void)?) {
        let view = moviesScreenBuilder.buildMovie(by: id, output: self)
        navigationController.pushViewController(view, animated: animated)
        completion?()
    }
    
    func startActors(byMovie id: Int, animated: Bool, completion: (() -> Void)?) {
        let view = moviesScreenBuilder.buildActorsList(byMovie: id, output: self)
        navigationController.pushViewController(view, animated: animated)
        completion?()
    }
    
    func startActor(by id: Int, animated: Bool, completion: (() -> Void)?) {
        let view = moviesScreenBuilder.buildActor(by: id, output: self)
        navigationController.pushViewController(view, animated: animated)
        completion?()
    }
    
    func popBack() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: - MoviesListOutput

extension MoviesCoordinator: MoviesListOutput {
    
    func moviesList(_ presenter: MoviesListPresenterProtocol, didSelectMovieWith id: Int) {
        startMovie(by: id, animated: true, completion: nil)
    }
}

// MARK: - MovieOutput

extension MoviesCoordinator: MovieOutput {
    func movie(_ presenter: MoviePresenterProtocol, didSelectActorsListBy id: Int) {
        startActors(byMovie: id, animated: true, completion: nil)
    }
    
    func movie(_ presenter: MoviePresenterProtocol, didNotFindMovieBy id: Int) {
        popBack()
    }
}

// MARK: - ActorsListOutput

extension MoviesCoordinator: ActorsListOutput {
    func actorsList(_ presenter: ActorsListPresenterProtocol, didSelectActorWith id: Int) {
        startActor(by: id, animated: true, completion: nil)
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
            self?.startMoviesList(animated: true, completion: nil)
        }
    }
    
    func makeMovieHandler() -> DeepLinkRoute {
        .init(path: "movies" / PathComponents.movieId) { [weak self] json in
            let movieId = json[PathComponents.movieId].intValue
            self?.startMovie(by: movieId, animated: true, completion: nil)
        }
    }
    
    func makeActorsListOfMovieHandler() -> DeepLinkRoute {
        .init(path: "movies" / PathComponents.movieId / "actors") { [weak self] json in
            let movieId = json[PathComponents.movieId].intValue
            self?.startMovie(by: movieId, animated: false, completion: nil)
            self?.startActors(byMovie: movieId, animated: true, completion: nil)
        }
    }
    
    func makeActorHandler() -> DeepLinkRoute {
        .init(path: "actors" / PathComponents.actorId) { [weak self] json in
            let actorId = json[PathComponents.actorId].intValue
            self?.startActor(by: actorId, animated: true, completion: nil)
        }
    }
}
