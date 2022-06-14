//
//  ActorPresenter.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation

protocol ActorOutput: AnyObject {
    func actor(_ presenter: ActorPresenterProtocol, didNotFindActorBy id: Int)
}

protocol ActorPresenterProtocol: AnyObject {
    func loadData()
}

final class ActorPresenter: ActorPresenterProtocol {
    
    // MARK: - Public properties
    
    var actor: Actor?
    
    weak var viewDelegate: ActorViewProtocol?
    
    // MARK: - Private properties
    
    private let actorId: Int
    private let actorsFetchService: ActorsFetchServiceProtocol
    private weak var output: ActorOutput?
    
    // MARK: - Initializers
    
    init(
        actorId: Int,
        actorsFetchService: ActorsFetchServiceProtocol,
        output: ActorOutput
    ) {
        self.actorId = actorId
        self.actorsFetchService = actorsFetchService
        self.output = output
    }
    
    // MARK: - Methods
    
    func loadData() {
        switch actorsFetchService.fetchActor(actorId: actorId) {
        case let .some(actor):
            self.actor = actor
            viewDelegate?.setActorData(actor)
            
        case .none:
            output?.actor(self, didNotFindActorBy: actorId)
        }
        
    }
}
