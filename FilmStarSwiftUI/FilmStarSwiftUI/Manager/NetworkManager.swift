import Foundation
import UIKit

enum FilmFetchType: String {
    case title = "t="
    case id = "i="
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://www.omdbapi.com/?"
    private let apiKey = "&apikey=653d2e0a"
    
    private init() {}
    
    func fetchFilm(fetchBy: FilmFetchType, with filmNameOrID: String) async throws -> Film {
        let endpoint = baseURL + fetchBy.rawValue + filmNameOrID + apiKey
        
        guard let url = URL(string: endpoint)
        else { throw FSError.wrongFormat }
        
        let request = URLRequest.init(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else { throw FSError.invalidResponse }
        
        do {
            let film = try JSONDecoder().decode(Film.self, from: data)
            return film
        } catch {
            throw FSError.invalidData
        }
    }
    
    func fetchPoster(with urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString)
        else { return nil }
        
        let request = URLRequest.init(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return UIImage(data: data)
    }
}
