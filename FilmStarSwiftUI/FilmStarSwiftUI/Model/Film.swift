import Foundation
import UIKit

protocol FilmProtocol: Identifiable, Codable, Equatable {
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
    func fetchImage() async throws -> UIImage?
    var posterImage: UIImage? { get set }
}

extension FilmProtocol {
    var id: String {
        return imdbID
    }
}

struct Film: FilmProtocol, PosterDisplayable {
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
    
    // MARK: - Displayable
    func fetchImage() async throws -> UIImage? {
        return try await NetworkManager.shared.fetchPoster(with: posterUrl)
    }
    
    var posterImage: UIImage?
    
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
}
