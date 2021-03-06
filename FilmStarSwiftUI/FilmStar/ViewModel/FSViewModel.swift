import SwiftUI
import RealityKit
import Combine

class FSViewModel: ObservableObject {
    
    /// Observed boolean that display a `ProgressView` on the `SearchScreen` when the data is being fetched
    @Published var isFetchingFilms: Bool = false
    
    /// Observed boolean that triggers presentation of `SearchFiltersScreen` to configure a search network call
    @Published var isChangingFilters: Bool = false
    
    var searchTypes = ["Any", "Movie", "Series", "Episode"]
    var searchYears: [String] = {
        let currentYear = Int(Calendar.current.component(.year, from: Date()))
        var searchYears = Array<Int>(1888...currentYear).reversed().map({ String($0) })
        searchYears.insert("Any", at: 0)
        return searchYears
    }()
    
    @Published var year = 0
    @Published var typeIndex = 0
    
    /// Observed `Film` that is being populated with the succesfull asynchronous fetching with `FSViewModel`'s `fetchFilm` method.
    @Published var film: Film? {
        didSet {
            if let film = film,
               film.posterImage == nil {
                fetchPosterData(for: film)
            }
        }
    }
    
    /// Observable boolean that triggers action leading to presenting `FilmSearchCollectionScreen`.
    ///
    /// Boolean is being triggered from the `SearchScreen`
    @Published var isShowingListOfFilms: Bool = false
    
    /// Observable array of `[FilmTeaser]`. Triggers presenting the `FilmSearchCollectionScreen` upon populating.
    ///
    /// Upon change from empty to not empty, property obsever toggles `isShowingListOfFilm` and thus `FilmSearchCollectionScreen` is being presented from the `SearchScreen`
    ///
    /// The initial trigger happens in the `SearchScreen` upon the user's tapGesture on the second out of two buttons. That triggers the `fetchListOfFilms` method from the `FSViewModel`. Then asynchronous fetching of spoken teasers happens.
    @Published var listOfTeasers: [FilmTeaser] = [] {
        didSet {
            if !listOfTeasers.isEmpty {
                isShowingListOfFilms = true
            } else {
                isShowingListOfFilms = false
            }
        }
    }
    
    /// Observable String to be included within the `URL` that will be used to fetch a single `Film` or an array of `FilmTeaser` depending on the pressed button from within `SearchScreen`
    ///
    /// Property is observed and toggles  the `isSearchTextFieldEmpty` boolean.
    @Published var searchFilmScreenText = "" {
        didSet {
            if searchFilmScreenText.isEmpty {
                isSearchTextFieldEmpty = true
            } else {
                isSearchTextFieldEmpty = false
            }
        }
    }
    
    /// Observable boolean that corresponds to `SearchFilmScreenText` being filled.
    ///
    /// The boolean will enable/disable both search buttons from the `SearchScreen` when `searchFilmScreenText` is filled/empty
    @Published var isSearchTextFieldEmpty = true
    
    
    /// Observed String by the `FetchingErrorView` from the `SearchScreen`.
    ///
    /// When the property has a value it means that the RawValue of the `FSFilmFetchingError` has been assigned to it, therefore fetching a `Film` or an array of `FilmTeaser` failed.
    ///
    /// Upon the value, an alert informing the user on failure will be presented above the `SearchFilmTextField` in the `SearchScreen` for 4 seconds
    @Published var searchingError: String? {
        didSet {
            if searchingError != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation {
                        self.searchingError = nil
                    }
                }
            }
        }
    }
    
    // MARK: - NetworkManager

    
    /// Fetches data about the movie or series and converts it to `Film`.
    /// - Parameter filmIdOrTitle: film's title or IMDb ID provided by the user.
    func fetchFilm(with filmIdOrTitle: String) {
        Task.init(priority: .high) { [weak self] in
            guard let self = self else { return }
            do {
                let (fetchType, filmIdOrTitle) = prepareForFilmFetching(with: filmIdOrTitle)
                let film = try await NetworkManager.shared.fetchFilm(fetchBy: fetchType, with: filmIdOrTitle, type: searchTypes[typeIndex], year: searchYears[year])
                if let film = film {
                    DispatchQueue.main.async {
                        self.film = film
                        withAnimation {
                            self.isFetchingFilms = false
                        }
                    }
                    fetchPosterData(for: film)
                }
            } catch let error {
                if let error = error as? FSFilmFetchingError {
                    DispatchQueue.main.async {
                        self.searchingError = error.rawValue
                        withAnimation {
                            self.isFetchingFilms = false
                        }
                    }
                }
            }
        }
    }
    
    
    /// Fetches a list of films or series and converts it to an array of `FilmTeaser`. Upon the sucesfull fetching, `FilmSearchCollectionScreen` is being presented with the displayed list.
    /// - Parameter filmTitle: Films title provided by the user. IMDb ID will not return any results. In case of IMDb ID being provided instead, the method will detect it and throw the information to the user above the TextField.
    func fetchListOfFilms(with filmTitle: String) {
        guard prepareForFilmFetching(with: filmTitle).0 != .id else {
            withAnimation {
                DispatchQueue.main.async {
                    self.isFetchingFilms = false
                }
            }
            searchingError = FSFilmFetchingError.titleNotId.rawValue
            return
        }
        Task.init(priority: .high) { [weak self] in
            guard let self = self else { return }
            do {
                let titlePrepared = filmTitle.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
                let films = try await NetworkManager.shared.fetchListOfFilms(with: titlePrepared, type: searchTypes[typeIndex], year: searchYears[year])
                if !films.isEmpty {
                    DispatchQueue.main.async {
                        self.listOfTeasers = films
                        withAnimation {
                            self.isFetchingFilms = false
                        }
                    }
                }
            } catch let error {
                if let error = error as? FSFilmFetchingError {
                    DispatchQueue.main.async {
                        self.searchingError = error.rawValue
                        withAnimation {
                            self.isFetchingFilms = false
                        }
                    }
                }
            }
        }
    }
    
    
    /// Fetches `Data` that can be transformed into the `UIImage` and `TextureResource` to represent film's poster.
    ///
    /// Upon success, the method directly assigns `UIImage` to `FSViewModel`'s `film`'s `posterImage` property. Then it assigns `TextureResource` to `arPostureTexture` subproperty.
    ///
    /// It's important to notice that upon succeful fetching and assigning those properties, some actions are being trigerred around the app.
    ///
    /// Currently the method is being fetched only for `Film`. Fetching for `FilmTeaser`s is being trigerred with the `DataTaskPublisher` from `FSImageLoader`
    ///
    /// - Parameter film: film fetched with the `func fetchFilm(with filmIdOrTitle: String)` method
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
                    self.film?.arPosterTexture = try? TextureResource.load(contentsOf: filePath)
                }
            }
        }
    }
    
    
    /// Method recognises wether a user passed the IMDb ID or a title.
    /// - Parameter titleOrId: Title or IMDb ID provided by the user
    /// - Returns: Returns lowercased IMDb ID to reach the requirement, or a fully prepared title with spaces replaced to + signs to reach the requirement
    func prepareForFilmFetching(with titleOrId: String) -> (FilmFetchType, String) {
        let trimmedTitleOrID = titleOrId.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedTitleOrID.count == 9,
           (String(trimmedTitleOrID.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((trimmedTitleOrID.dropFirst(2)) as NSString).integerValue != 0 {
            let id = trimmedTitleOrID.lowercased()
            return (FilmFetchType.id, id)
        } else if trimmedTitleOrID.count == 10,
                  (String(trimmedTitleOrID.dropLast(8)).filter({ $0.isLetter })).count == 2,
                  ((trimmedTitleOrID.dropFirst(2)) as NSString).integerValue != 0 {
            let id = trimmedTitleOrID.lowercased()
            return (FilmFetchType.id, id)
        } else {
            return (FilmFetchType.title, trimmedTitleOrID.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+"))
        }
    }
    
    // MARK: - AR Screens
    
    /// Observed boolean triggered with the button from the FilmDetailsScreen to activate the AR Experience
    @Published var isPresentingARExperience: Bool = false
}

