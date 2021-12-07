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
    var arPosterTexture: TextureResource? { get set }
}

extension FilmProtocol {
    var id: String {
        return imdbID
    }
}

typealias Filmable = FilmProtocol & PosterDisplayable

struct Film: Filmable {
    // MARK: - Properties
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
    var arPosterTexture: TextureResource?
    
    // MARK: - Codable
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
}
