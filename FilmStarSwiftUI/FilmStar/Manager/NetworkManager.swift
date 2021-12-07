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
    
    func fetchFilm(fetchBy: FilmFetchType, with filmNameOrID: String) async throws -> Film? {
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
            throw FSError.noDataTitleID
        }
    }
    
    func fetchListOfFilms(with filmName: String) async throws -> [FilmShort] {
        let endpoint = baseURL + "s=" + filmName + apiKey
        
        guard let url = URL(string: endpoint)
        else { throw FSError.wrongFormat }
        
        let request = URLRequest.init(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else { throw FSError.invalidResponse }
        
        do {
            let results = try JSONDecoder().decode(SearchResult.self, from: data)
            return results.films.filter({ $0.type == "movie" })
        } catch let error {
            print(error.localizedDescription)
            throw FSError.noDataTitle
        }
    }
    
    func fetchPosterData(with urlString: String) async throws -> Data? {
        guard let url = URL(string: urlString)
        else { return nil }
        
        let request = URLRequest.init(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return data
    }
}
