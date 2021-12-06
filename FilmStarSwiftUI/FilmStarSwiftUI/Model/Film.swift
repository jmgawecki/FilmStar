import Foundation
import UIKit
import RealityKit

protocol FilmProtocol: Identifiable, Codable {
    var title: String { get set }
    var year: String { get set }
    var released: String { get set }
    var genre: String { get set }
    var director: String { get set }
    var writer: String { get set }
    var actors: String { get set }
    var plot: String { get set }
    var awards: String { get set }
    var posterUrl: String { get set }
    var ratings: [FilmRating] { get set }
    var imdbID: String { get set }
    var boxOffice: String { get set }
    var id: String { get }
}

protocol PosterDisplayable {
    var posterImage: UIImage? { get set }
    var arResource: TextureResource? { get set }
}

protocol FilmAccessible {
    var writerAccessible: String { get }
    var actorsAccessible: String { get }
}

extension FilmProtocol {
    var id: String {
        return imdbID
    }
}

typealias Filmable = FilmProtocol & PosterDisplayable

struct Film: Filmable {
    var title: String
    var year: String
    var released: String
    var genre: String
    var director: String
    var writer: String
    var isFavourite: Bool = false
    var actors: String
    var plot: String
    var awards: String
    var posterUrl: String
    var ratings: [FilmRating]
    var imdbID: String
    var boxOffice: String
    
    // MARK: - Displayable
    var posterImage: UIImage?
    var arResource: TextureResource?
    
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case released = "Released"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case awards = "Awards"
        case posterUrl = "Poster"
        case ratings = "Ratings"
        case imdbID
        case boxOffice = "BoxOffice"
    }
    
    
    // MARK: - tatic Mocks
    static let mock = Film(
        title: "Guardians of the Galaxy Vol. 2",
        year: "2017",
        released: "05 May 2017",
        genre: "Action, Adventure, Comedy",
        director: "James Gunn",
        writer: "James Gunn, Dan Abnett, Andy Lanning",
        actors: "Chris Pratt, Zoe Saldana, Dave Bautista",
        plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
        awards: "Nominated for 1 Oscar. 15 wins & 58 nominations total",
        posterUrl: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg",
        ratings: [
            FilmRating(
                source: "Internet Movie Database",
                value: "7.6/10"
            ),
            FilmRating(
                source: "Rotten Tomatoes",
                value: "85%"
            ),
            FilmRating(
                source: "Metacritic",
                value: "67/100"
            )
        ],
        imdbID: "tt3896198",
        boxOffice: "$389,813,101"
    )
    
    static let mockOptional: Film? = Film(
        title: "Guardians of the Galaxy Vol. 2",
        year: "2017",
        released: "05 May 2017",
        genre: "Action, Adventure, Comedy",
        director: "James Gunn",
        writer: "James Gunn, Dan Abnett, Andy Lanning",
        actors: "Chris Pratt, Zoe Saldana, Dave Bautista",
        plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
        awards: "Nominated for 1 Oscar. 15 wins & 58 nominations total",
        posterUrl: "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg",
        ratings: [
            FilmRating(
                source: "Internet Movie Database",
                value: "7.6/10"
            ),
            FilmRating(
                source: "Rotten Tomatoes",
                value: "85%"
            ),
            FilmRating(
                source: "Metacritic",
                value: "67/100"
            )
        ],
        imdbID: "tt3896198",
        boxOffice: "$389,813,101"
    )
}
