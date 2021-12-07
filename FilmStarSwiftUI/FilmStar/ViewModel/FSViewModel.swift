import SwiftUI
import RealityKit
import Combine

class FSViewModel: ObservableObject {
    @Published var film: Film? {
        didSet {
            if let film = film,
               film.posterImage == nil {
                fetchPosterData(for: film)
            }
            
        }
    }
    @Published var isShowingListOfFilms: Bool = false
    
    @Published var listOfFilms: [FilmShort] = [] {
        didSet {
            if !listOfFilms.isEmpty {
                isShowingListOfFilms = true
            } else {
                isShowingListOfFilms = false
            }
        }
    }
    @Published var searchText = ""
    @Published var isSearchTextFieldEmpty = true
    @Published var searchingError: String? {
        didSet {
            if searchingError != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.searchingError = nil
                }
            }
        }
    }
    
    // MARK: - Initialiser
    init() {
        isSearchTextFieldEmptyPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isSearchTextFieldEmpty, on: self)
            .store(in: &subscriptions)
    }
    
    // MARK: - Concurrency
    private var subscriptions = Set<AnyCancellable>()
    
    private var isSearchTextFieldEmptyPublisher: AnyPublisher<Bool, Never> {
        $searchText
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
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
                if let error = error as? FSError {
                    DispatchQueue.main.async {
                        self.searchingError = error.rawValue
                    }
                }
            }
        }
    }
    
    func fetchListOfFilms(with filmTitle: String) {
        Task.init(priority: .high) { [weak self] in
            guard let self = self else { return }
            do {
                let titlePrepared = filmTitle.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
                let films = try await NetworkManager.shared.fetchListOfFilms(with: titlePrepared)
                if !films.isEmpty {
                    DispatchQueue.main.async {
                        self.listOfFilms = films
                    }
                }
            } catch let error {
                if let error = error as? FSError {
                    DispatchQueue.main.async {
                        self.searchingError = error.rawValue
                    }
                }
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
//
//    func fetchPosters() {
//        listOfFilms.map({ $0.title = "asf" })
//        listOfFilms.forEach { film in
//            Task.init(priority: .high) { [weak self] in
//                guard let self = self else { return }
//                let data = try await NetworkManager.shared.fetchPosterData(with: film.posterUrl)
//                if let data = data {
//                    DispatchQueue.main.async {
//
//                    }
//                    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("posterTexureResource")
//
//                    try? data.write(to: filePath)
//                    DispatchQueue.main.async {
//                        self.film?.arResource = try? TextureResource.load(contentsOf: filePath)
//                    }
//                }
//            }
//        }
//
//    }
    
    func prepareForFilmFetching(with titleOrId: String) -> (FilmFetchType, String) {
        if titleOrId.count == 9,
           (String(titleOrId.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((titleOrId.dropFirst(2)) as NSString).integerValue != 0 {
            let id = titleOrId.lowercased()
            return (FilmFetchType.id, id)
        } else if titleOrId.count == 10,
                  (String(titleOrId.dropLast(8)).filter({ $0.isLetter })).count == 2,
                  ((titleOrId.dropFirst(2)) as NSString).integerValue != 0 {
            let id = titleOrId.lowercased()
            return (FilmFetchType.id, id)
        } else {
            return (FilmFetchType.title, titleOrId.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+"))
        }
    }
    
    // MARK: - AR Screens
    @Published var isARPresenting: Bool = false
    @Published var isCoachingActive: Bool = false
    
    // MARK: - Error handling
}

