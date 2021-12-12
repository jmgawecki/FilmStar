import Foundation
import UIKit
import RealityKit

// MARK: - FilmShort

/// Protocol serves as a requirement to both `Film` and `FilmTeaser` structs.
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

// MARK: - FilmExtended
/// Protocol serves as an extended requirement to `Film` struct. Its a natural extension of `FilmShortProtocol`
protocol FilmExtendedProtocol {
    associatedtype Rating = FilmRatingProtocol
    var released: String { get set }
    var genre: String { get set }
    var director: String { get set }
    var writer: String { get set }
    var actors: String { get set }
    var plot: String { get set }
    var awards: String { get set }
    var ratings: [Rating] { get set }
    var boxOffice: String? { get set }
}

// MARK: - FilmRating
protocol FilmRatingProtocol: Codable, Equatable, Identifiable {
    var source: String { get set }
    var value: String { get set }
    var id: String { get }
}

extension FilmRatingProtocol {
    var id: String {
        return source
    }
}

// MARK: - PosterDisplayable

/// Protocol serves as a requirement to `Film` struct.
///
/// Protocol plays a major role for AR Experience and for displaying Image.
protocol PosterDisplayable {
    var posterImage: UIImage? { get set }
    var arPosterTexture: TextureResource? { get set }
}

// MARK: - Filmable
typealias Filmable = FilmShortProtocol & FilmExtendedProtocol & PosterDisplayable

