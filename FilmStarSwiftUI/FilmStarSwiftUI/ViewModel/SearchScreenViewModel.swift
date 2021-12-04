import SwiftUI
import RealityKit

class SearchScreenViewModel: ObservableObject {
    @Published var film: Film?
    @Published var searchText = ""
//    @Published var posterImage: UIImage?
    
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
    
    func fetchFilm(with filmIdOrTitle: String) {
        Task.init(priority: .high) { [weak self] in
            guard let self = self else { return }
            if filmIdOrTitle.count == 9,
               (String(filmIdOrTitle.dropLast(7)).filter({ $0.isLetter })).count == 2,
               ((filmIdOrTitle.dropFirst(2)) as NSString).integerValue != 0 {
                do {
                    let film = try await NetworkManager.shared.fetchFilm(fetchBy: .id, with: filmIdOrTitle)
                    if let film = film {
                        DispatchQueue.main.async {
                            self.film = film
                        }
                        fetchPosterData(for: film)
                    }
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            } else {
                do {
                    let film = try await NetworkManager.shared.fetchFilm(fetchBy: .title, with: preparedTitle(from: filmIdOrTitle))
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
        @Sendable func preparedTitle(from title: String) -> String {
            title.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        }
    }
    
    // MARK: - ARScreens
    @Published var isARPresenting: Bool = false
    @Published var isCoachingActive: Bool = false
}
