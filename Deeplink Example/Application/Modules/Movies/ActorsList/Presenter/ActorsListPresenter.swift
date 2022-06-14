//
//  ActorsListPresenter.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 12.06.2022.
//

import Foundation

protocol ActorsListOutput: AnyObject {
    func actorsList(_ presenter: ActorsListPresenterProtocol, didSelectActorWith id: Int)
}

protocol ActorsListPresenterProtocol: AnyObject {
    var actors: [Actor] { get }
    
    func loadData()
    func didSelectActor(by index: Int)
}

final class ActorsListPresenter: ActorsListPresenterProtocol {
    
    // MARK: - Properties
    
    let movieId: Int
    var actors: [Actor] = []
    
    weak var viewDelegate: ActorsListViewProtocol?
    
    // MARK: - Private properties
    
    private let actorsFetchService: ActorsFetchServiceProtocol
    private weak var output: ActorsListOutput?
    
    // MARK: - Initializers
    
    init(
        movieId: Int,
        actorsFetchService: ActorsFetchServiceProtocol,
        output: ActorsListOutput?
    ) {
        self.movieId = movieId
        self.actorsFetchService = actorsFetchService
        self.output = output
    }
    
    // MARK: - Methods
    
    func loadData() {
        let actors = actorsFetchService.fetchActors(movieId: movieId)
        self.actors = actors
        viewDelegate?.reloadData()
    }
    
    func didSelectActor(by index: Int) {
        let actor = actors[index]
        output?.actorsList(self, didSelectActorWith: actor.id)
    }
}
