import Foundation

protocol FilmRatingProtocol: Codable, Equatable {
    var source: String { get set }
    var value: String { get set }
}

struct FilmRating: FilmRatingProtocol {
    var source: String
    var value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
