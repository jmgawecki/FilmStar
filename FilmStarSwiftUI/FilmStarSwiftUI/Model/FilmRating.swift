import Foundation

protocol FilmRatingProtocol: Codable, Equatable, Identifiable {
    var source: String { get set }
    var value: String { get set }
    var id: UUID { get }
}

extension FilmRatingProtocol {
    var id: UUID {
        return UUID()
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
