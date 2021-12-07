import Foundation
import UIKit

protocol FilmShortProtocol: Identifiable, Codable {
    var title: String { get set }
    var year: String { get set }
    var type: String { get set }
    var posterUrl: String { get set }
    var posterImage: UIImage? { get set }
    var id: String { get }
    var imdbID: String { get set }
}

extension FilmShortProtocol {
    var id: String {
        return imdbID
    }
}


/// `FilmTeaser` is the result of fetching whole list of films with the `s=` url modifier.
///
/// `FilmTeaser` is being used to display results in `FilmsListScreen`
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
