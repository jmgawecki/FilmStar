import UIKit
import RealityKit

struct FilmMock: FilmProtocol, PosterDisplayable, Codable {
    var title: String
    var year: String
    var rated: String
    var released: String
    var runtime: String
    var genre: String
    var director: String
    var writer: String
    var actors: String
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
    
    // MARK: - Displayable
    var posterImage: UIImage?
    var arResource: TextureResource?

    // MARK: - static Mocks
    static let gogv2 = FilmMock(
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
