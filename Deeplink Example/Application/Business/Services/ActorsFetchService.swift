//
//  ActorsFetchService.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 12.06.2022.
//

import UIKit

protocol ActorsFetchServiceProtocol: AnyObject {
    func fetchActors() -> [Actor]
    func fetchActor(actorId: Int) -> Actor?
    func fetchActors(movieId: Int) -> [Actor]
}

final class ActorsFetchService: ActorsFetchServiceProtocol {
    
    
    // MARK: - Methods
    
    func fetchActors() -> [Actor] {
        [
            .init(
                id: 1,
                imageData: UIImage(named: "actor.1")?.jpegData(compressionQuality: 1),
                name: "Millie Bobby Brown",
                movieIds: [1]
            ),
            .init(
                id: 2,
                imageData: UIImage(named: "actor.2")?.jpegData(compressionQuality: 1),
                name: "Finn Wolfhard",
                movieIds: [1]
            ),
            .init(
                id: 3,
                imageData: UIImage(named: "actor.3")?.jpegData(compressionQuality: 1),
                name: "Caleb McLaughlin",
                movieIds: [2]
            ),
            .init(
                id: 4,
                imageData: UIImage(named: "actor.4")?.jpegData(compressionQuality: 1),
                name: "Gaten Matarazzo",
                movieIds: [2]
            ),
            .init(
                id: 5,
                imageData: UIImage(named: "actor.5")?.jpegData(compressionQuality: 1),
                name: "Winona Ryder",
                movieIds: [2]
            )
        ]
    }
    
    func fetchActor(actorId: Int) -> Actor? {
        fetchActors().first(where: { $0.id == actorId })
    }
    
    func fetchActors(movieId: Int) -> [Actor] {
        fetchActors().filter({ $0.movieIds.contains(movieId) })
    }
}
