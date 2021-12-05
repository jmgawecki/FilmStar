import Foundation
import UIKit
import RealityKit

protocol FilmProtocol: Identifiable, Codable {
    var title: String { get set }
    var year: String { get set }
    var rated: String { get set } // ??
    var released: String { get set } // Date String format or Date format?
    var runtime: String { get set }
    var genre: String { get set }
    var director: String { get set }
    var writer: String { get set }
    var actors: String { get set }
    var plot: String { get set }
    var language: String { get set }
    var country: String { get set }
    var awards: String { get set }
    var posterUrl: String { get set }
    var ratings: [FilmRating] { get set }
    var metaScore: String { get set }
    var imdbRating: String { get set }
    var imdbVotes: String { get set }
    var imdbID: String { get set }
    var type: String { get set }
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

struct Film: Filmable, FilmAccessible {
    var title: String
    var year: String
    var rated: String
    var released: String
    var runtime: String
    var genre: String
    var director: String
    var writer: String
    var writerAccessible: String {
        return writer
    }
    var actors: String
    var actorsAccessible: String {
        return actors
    }
    var plot: String
    var language: String
    var country: String
    var awards: String
    var posterUrl: String
    var ratings: [FilmRating]
    var metaScore: String
    var imdbRating: String
    var imdbVotes: String
    var imdbID: String
    var type: String
    var boxOffice: String
    
    // MARK: - Displayable
    var posterImage: UIImage?
    var arResource: TextureResource?
    
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case posterUrl = "Poster"
        case ratings = "Ratings"
        case metaScore = "Metascore"
        case imdbRating
        case imdbVotes
        case imdbID
        case type = "Type"
        case boxOffice = "BoxOffice"
    }
    
    
    // MARK: - tatic Mocks
    static let mock = Film(
        title: "Guardians of the Galaxy Vol. 2",
        year: "2017",
        rated: "PG-13",
        released: "05 May 2017",
        runtime: "136 min",
        genre: "Action, Adventure, Comedy",
        director: "James Gunn",
        writer: "James Gunn, Dan Abnett, Andy Lanning",
        actors: "Chris Pratt, Zoe Saldana, Dave Bautista",
        plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
        language: "English",
        country: "United States",
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
        metaScore: "67",
        imdbRating: "7.6",
        imdbVotes: "617,524",
        imdbID: "tt3896198",
        type: "movie",
        boxOffice: "$389,813,101"
    )
    
    static let mockOptional: Film? = Film(
        title: "Guardians of the Galaxy Vol. 2",
        year: "2017",
        rated: "PG-13",
        released: "05 May 2017",
        runtime: "136 min",
        genre: "Action, Adventure, Comedy",
        director: "James Gunn",
        writer: "James Gunn, Dan Abnett, Andy Lanning",
        actors: "Chris Pratt, Zoe Saldana, Dave Bautista",
        plot: "The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.",
        language: "English",
        country: "United States",
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
        metaScore: "67",
        imdbRating: "7.6",
        imdbVotes: "617,524",
        imdbID: "tt3896198",
        type: "movie",
        boxOffice: "$389,813,101"
    )
}
