import Foundation
import UIKit

enum FilmFetchType: String {
    case title = "t="
    case id = "i="
}

/// Singleton for fetching data that is then transformed into `Film`, `FilmRating`, `FilmTeaser`, `UIImage`, and `TextureResource`
class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://www.omdbapi.com/?"
    private let apiKey = "&apikey=653d2e0a"
    
    private init() {}
    
    
    /// Fetches a single film and returns it as `Film` struct.
    /// - Parameters:
    ///   - fetchBy: `FilmFetchType` decides wether the fetch should be performed for a title or IMDb ID.
    ///   - filmNameOrID: provided film's title or film's IMDbID
    /// - Returns: `Film`'s instance
    func fetchFilm(fetchBy: FilmFetchType, with filmTitleOrID: String) async throws -> Film? {
        let endpoint = baseURL + fetchBy.rawValue + filmTitleOrID + apiKey
        
        guard let url = URL(string: endpoint)
        else { throw FSFilmFetchingError.wrongFormat }
        
        let request = URLRequest.init(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else { throw FSFilmFetchingError.invalidResponse }
        
        do {
            let film = try JSONDecoder().decode(Film.self, from: data)
            return film
        } catch {
            throw FSFilmFetchingError.noDataTitleID
        }
    }
    
    /// Fetches a list of films and returns it as an array of `FilmTeaser` struct. Results that are fetched may differ.
    /// - Parameter filmName: Film's approximate or precised title
    /// - Returns: Array of `FilmTeaser`s
    func fetchListOfFilms(with filmName: String) async throws -> [FilmTeaser] {
        let endpoint = baseURL + "s=" + filmName + apiKey
        
        guard let url = URL(string: endpoint)
        else { throw FSFilmFetchingError.wrongFormat }
        
        let request = URLRequest.init(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else { throw FSFilmFetchingError.invalidResponse }
        
        do {
            let results = try JSONDecoder().decode(SearchResult.self, from: data)
            return results.films.filter({ $0.type == "movie" })
        } catch let error {
            print(error.localizedDescription)
            throw FSFilmFetchingError.noDataTitle
        }
    }
    
    
    /// Fetches film's poster to be later transformed into a `UIImage` or a `TextureResource`
    /// - Parameter urlString: URL for the image.
    /// - Returns: `Data` to be later transformed into a `UIImage` or a `TextureResource`
    func fetchPosterData(with urlString: String) async throws -> Data? {
        guard let url = URL(string: urlString)
        else { return nil }
        
        let request = URLRequest.init(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return data
    }
}
