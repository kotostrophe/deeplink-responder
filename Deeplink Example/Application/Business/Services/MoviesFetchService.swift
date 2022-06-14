//
//  MoviesFetchService.swift
//  Deeplink Example
//
//  Created by Тарас Коцур on 11.06.2022.
//

import Foundation
import UIKit

protocol MoviesFetchServiceProtocol: AnyObject {
    func fetchMovies() -> [Movie]
    func fetchMovie(movieId: Int) -> Movie?
    func fetchMovies(actorId: Int) -> [Movie]
}

final class MoviesFetchService: MoviesFetchServiceProtocol {
    
    func fetchMovies() -> [Movie] {
        return [
            .init(
                id: 1,
                imageData: UIImage(named: "movie.1")?.jpegData(compressionQuality: 1),
                title: "Хлопаки",
                description: "Хлопаки — це непоштивий погляд на ситуацію, коли супергерої, знамениті як зірки, впливові як політики і шановані, як боги, зловживають суперсилами замість того, щоб творити добро. \n\nБезсилі проти надмогутніх, «Хлопаки» вирушають на героїчний бій за правду щодо «Сімки» та їх грізних покровителів — Воут (Мандри).",
                rating: 84,
                yearOfPublishing: "2019",
                actorIds: [1, 2, 3]
            ),
            
            .init(
                id: 2,
                imageData: UIImage(named: "movie.2")?.jpegData(compressionQuality: 1),
                title: "Дивні дива",
                description: "6 листопада 1983 року в штаті Індіана таємничим чином зникає 12-річний Вілл Баєрс. Мати зниклого хлопчика, Джойс, не знаходить собі місця, намагаючись знайти сина. По допомогу вона звертається до начальника поліції Гоппера, який починає розслідувати зникнення. Друзі Вілла теж вирушають на пошуки зниклого, але зустрічають у лісі дівчинку з незвичайними здібностями, яка щось знає про їх зниклого друга.",
                rating: 86,
                yearOfPublishing: "2016",
                actorIds: [4, 5]
            )
        ]
    }
    
    
    func fetchMovie(movieId: Int) -> Movie? {
        fetchMovies().first(where: { $0.id == movieId })
    }
    
    func fetchMovies(actorId: Int) -> [Movie] {
        fetchMovies().filter({ $0.actorIds.contains(actorId) })
    }
}
