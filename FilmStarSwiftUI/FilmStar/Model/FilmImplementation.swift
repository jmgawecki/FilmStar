import UIKit
import RealityKit


/// Struct to present information about the `Film` within `FilmDetailsScreen`.
///
/// Struct confroms to `FilmShortProtocol`, `FilmExtendedProtocol`, and `PosterDisplayable`
struct Film: Filmable {
    var title: String
    var year: String
    var released: String
    var genre: String
    var director: String
    var writer: String
    var type: String
    var isFavourite: Bool = false
    var actors: String
    var plot: String
    var awards: String
    var posterUrl: String
    var ratings: [FilmRating]
    var imdbID: String
    var boxOffice: String?
    
    var posterImage: UIImage?
    var arPosterTexture: TextureResource?
    
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
        case type = "Type"
    }
}

struct FilmRating: FilmRatingProtocol {
    var source: String
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

/// `FilmTeaser` is the result of fetching whole list of films with the `s=` url modifier.
///
/// `FilmTeaser` is being used to display results in `FilmsListScreen` and `FavouritesFilmScreen`
///
/// Struct conforms to `FilmShortProtocol`
struct FilmTeaser: FilmShortProtocol {
    var imdbID: String
    var title: String
    var year: String
    var type: String
    var posterUrl: String
    var posterImage: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case posterUrl = "Poster"
        case imdbID
    }
}

/// `SearchResult` is a placeholder structure for fetchin an array of `FilmTeaser`
struct SearchResult: Codable {
    var films: [FilmTeaser]
    
    enum CodingKeys: String, CodingKey {
        case films = "Search"
    }
}
