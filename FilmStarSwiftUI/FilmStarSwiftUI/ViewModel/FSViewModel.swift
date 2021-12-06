import SwiftUI
import RealityKit

class FSViewModel: ObservableObject {
    @Published var film: Film? {
        didSet {
            if let film = film,
               film.posterImage == nil {
                fetchPosterData(for: film)
            }
            
        }
    }
    @Published var searchText = ""
    
    // MARK: - CoreData
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \FSFilmSum.imdbID,
                ascending: true
            )
        ],
        animation: .default)
    
    var films: FetchedResults<FSFilmSum>
    
    var filmSum: FSFilmSum? {
        return films.filter({ $0.imdbID == film?.imdbID }).first
    }
    
    // MARK: - NetworkManager
    func fetchFilm(with filmIdOrTitle: String) {
        Task.init(priority: .high) { [weak self] in
            guard let self = self else { return }
            do {
                let (fetchType, filmIdOrTitle) = prepareForFilmFetching(with: filmIdOrTitle)
                let film = try await NetworkManager.shared.fetchFilm(fetchBy: fetchType, with: filmIdOrTitle)
                if let film = film {
                    DispatchQueue.main.async {
                        self.film = film
                    }
                    fetchPosterData(for: film)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPosterData(for film: Film) {
        Task.init(priority: .high) { [weak self] in
            guard let self = self else { return }
            let data = try await NetworkManager.shared.fetchPosterData(with: film.posterUrl)
            if let data = data {
                DispatchQueue.main.async {
                    self.film?.posterImage = UIImage(data: data)
                }
                let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("posterTexureResource")
                
                try? data.write(to: filePath)
                DispatchQueue.main.async {
                    self.film?.arResource = try? TextureResource.load(contentsOf: filePath)
                }
            }
        }
    }
    
    func prepareForFilmFetching(with titleOrId: String) -> (FilmFetchType, String) {
        if titleOrId.count == 9,
           (String(titleOrId.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((titleOrId.dropFirst(2)) as NSString).integerValue != 0 {
            return (FilmFetchType.id, titleOrId)
        } else if titleOrId.count == 10,
                  (String(titleOrId.dropLast(8)).filter({ $0.isLetter })).count == 2,
                  ((titleOrId.dropFirst(2)) as NSString).integerValue != 0 {
            return (FilmFetchType.id, titleOrId)
        } else {
            return (FilmFetchType.title, titleOrId.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+"))
        }
    }
    
    // MARK: - AR Screens
    @Published var isARPresenting: Bool = false
    @Published var isCoachingActive: Bool = false
}
