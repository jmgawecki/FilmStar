import SwiftUI

class SearchScreenViewModel: ObservableObject {
    @Published var film: Film?
    {
        didSet {
            Task.init(priority: .high) { [weak self] in
                guard let self = self else { return }
                if let posterUrl = film?.posterUrl {
                    let poster = try await NetworkManager.shared.fetchPoster(with: posterUrl)

                    DispatchQueue.main.async {
                        self.posterImage = poster
                    }
                }
            }
        }
    }
    
    @Published var posterImage: UIImage?
    
    func fetchFilm(with filmIdOrTitle: String) {
        Task.init(priority: .high) { [weak self] in
            guard let self = self else { return }
            if filmIdOrTitle.count == 9,
               (String(filmIdOrTitle.dropLast(7)).filter({ $0.isLetter })).count == 2,
               ((filmIdOrTitle.dropFirst(2)) as NSString).integerValue != 0 {
                do {
                    let film = try await NetworkManager.shared.fetchFilm(fetchBy: .id, with: filmIdOrTitle)
                    
                    DispatchQueue.main.async {
                        self.film = film
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            } else {
                do {
                    let film = try await NetworkManager.shared.fetchFilm(fetchBy: .title, with: preparedTitle(from: filmIdOrTitle))
                    
                    DispatchQueue.main.async {
                        self.film = film
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
    
    
}
