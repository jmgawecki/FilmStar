import SwiftUI

struct FilmDetailsScreen: View {
    @ObservedObject var viewModel: FSViewModel
    @AccessibilityFocusState var isScreenFocused: Bool
    
    var body: some View {
        if let film = viewModel.film {
            ScrollView(.vertical) {
                ZStack {
                    VStack() {
                        ButtonsPanel(viewModel: viewModel)
                            .accessibilitySortPriority(6)
                        
                        Poster(viewModel: viewModel)
                        
                        HeaderView(film: film)
                            .padding(.horizontal, 10)
                            .accessibilitySortPriority(10)
                            .accessibilityFocused($isScreenFocused)
                        
                        FirstDetailView(film: film)
                            .padding(.horizontal, 10)
                            .accessibilitySortPriority(9)
                        
                        SecondDetailView(film: film)
                            .padding(.horizontal)
                            .accessibilitySortPriority(8)
                        
                        RatingsVGrid(film: film)
                            .padding(.horizontal, 10)
                            .accessibilitySortPriority(7)
                        Spacer()
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct FilmDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FilmDetailsScreen(viewModel: FSViewModel())
                .preferredColorScheme(.dark)
            FilmDetailsScreen(viewModel: FSViewModel())
                .preferredColorScheme(.light)
        }
    }
}

// MARK: - Fileprivate Views
fileprivate struct ButtonsPanel: View {
    @ObservedObject var viewModel: FSViewModel
    @State var isShowingError: Bool = false {
        didSet {
            if isShowingError == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isShowingError = false
                    }
                }
            }
        }
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \FSFilmSum.imdbID,
                ascending: true
            )
        ],
        animation: .default) var films: FetchedResults<FSFilmSum>
    
    var body: some View {
        VStack {
            if isShowingError {
                Text("Something went wrong. Please try again.")
                    .frame(width: 300, height: 50)
                    .font(.caption)
                    .foregroundColor(Color.red)
                    .accessibilityHidden(true)
            }
            HStack {
                if let film = viewModel.film,
                   let filmCored = films.filter({ $0.imdbID == film.imdbID }).first,
                   let isFavourite = filmCored.isFavourite {
                    FSBorederedButton(
                        title: isFavourite ? "Saved" : "Save",
                        systemImage: isFavourite ? "star.fill" : "star",
                        colour: .purple,
                        size: .large,
                        isAnimated: true,
                        accessibilityLabel: "Save to favourites",
                        accessibilityHint: "Double tap to add Film to your favourites") {
                            changeFavouritesStatus()
                        }
                }
                
                FSBorederedButton(
                    title: "AR Poster",
                    systemImage: "arkit",
                    colour: .purple,
                    size: .large,
                    accessibilityLabel: "A R Poster",
                    accessibilityHint: "A R Experience is not accessibility-friendly. We apologise for the incovienience.") {
                        viewModel.isARPresenting.toggle()
                    }
                    .fullScreenCover(
                        isPresented: $viewModel.isARPresenting,
                        onDismiss: nil) {
                            PosterARScreen(viewModel: viewModel)
                        }
                
                FSBorederedButton(
                    title: "",
                    systemImage: "xmark",
                    colour: .yellow,
                    size: .large,
                    accessibilityLabel: "Go back") {
                        viewModel.film = nil
                    }
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .onAppear {
            if let film = viewModel.film {
                add(film)
            }
        }
    }
    
    
    /// Method to save film as `FSFilmSum` model into CoreData.
    ///
    /// Methods is being called immediately after loading the `FilmDetailsScreen` as it reflects all recent successful searches performed by the user
    /// - Parameter film: Method takes `Film` instance and converts it into `FSFilmSum` object that can be saved in CoreData.
    func add(_ film: Film) {
        if ((films.filter({ $0.imdbID == film.imdbID }).first) == nil) {
            withAnimation {
                let newFilm = FSFilmSum(context: viewContext)
                newFilm.imdbID = film.imdbID
                newFilm.title = film.title
                newFilm.posterUrl = film.posterUrl
                newFilm.genre = film.genre
                newFilm.director = film.director
                newFilm.isFavourite = false
                newFilm.timestamp = Date()
            }
        } else if let film = films.filter({ $0.imdbID == film.imdbID }).first {
            film.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {}
    }
    
    /// Methods changes `FSFilmSum`'s `isFavourite` property that is already being stored within the CoreData
    ///
    /// Currently the change is performed on film that's id matches the observed film property from within the `FSViewModel`.
    func changeFavouritesStatus() {
        if let recent = films.filter({ $0.imdbID == viewModel.film?.imdbID }).first {
            recent.isFavourite.toggle()
            do {
                try viewContext.save()
            } catch {
                withAnimation {
                    isShowingError = true
                }
            }
        }
    }
}

fileprivate struct Poster: View {
    @ObservedObject var viewModel: FSViewModel
    @State private var isShowingPoster = false
    
    var body: some View {
        ZStack {
            if isShowingPoster {
                if let poster = viewModel.film?.posterImage {
                    Image(uiImage: poster)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .cornerRadius(10)
                        .padding(.top)
                        .accessibilityHidden(true)
                }
            }
        }
        .onChange(of: viewModel.film?.posterImage) { image in
            withAnimation {
                if image != nil {
                    isShowingPoster = true
                }
            }
        }
    }
}

fileprivate struct HeaderView: View {
    var film: Film
    var body: some View {
        ColouredVPadder(
            backgroundColour: .purple,
            cornerRadius: 12,
            alignment: .leading) {
                Text("\(film.title) (\(film.year))")
                    .minimumScaleFactor(0.3)
                    .font(.title2)
                    .lineLimit(2)
                    .accessibilityHidden(true)
                
                Text(film.plot)
                    .font(.callout)
                    .accessibilityHidden(true)
            }
            .accessibilityElement(children: .combine)
            .accessibilityCustomContent(.title, "\(film.title). Released in (\(film.year))", importance: .high)
            .accessibilityCustomContent(.plot, film.plot)
            .accessibilityAddTraits(.isHeader)
            .accessibilityHint("Swipe down for the plot.")
    }
    
}

fileprivate struct FirstDetailView: View {
    var film: Film
    var body: some View {
        ColouredVPadder(
            backgroundColour: .purple,
            cornerRadius: 12,
            alignment: .leading) {
                Text(film.genre)
                    .font(.callout)
                    .accessibilitySortPriority(10)
                Text("Directed by \(film.director)")
                    .font(.callout)
                    .accessibilitySortPriority(9)
                Text("Written by \(film.writer)")
                    .font(.caption)
                    .accessibilitySortPriority(8)
                Text("Actors: \(film.actors)")
                    .font(.caption)
                    .accessibilitySortPriority(7)
                
            }
            .accessibilityHidden(true)
            .accessibilityElement(children: .combine)
            .accessibilityCustomContent(.genre, film.genre, importance: .high)
            .accessibilityCustomContent(.director, "Directed by \(film.director)")
            .accessibilityCustomContent(.writer, "Written by \(film.writer)")
            .accessibilityCustomContent(.actors, "Actors: \(film.actors)")
            .accessibilityHint("Swipe down for more info")
    }
}

fileprivate struct SecondDetailView: View {
    var film: Film
    var body: some View {
        ColouredVPadder(
            backgroundColour: .purple,
            cornerRadius: 12,
            alignment: .leading) {
                Text(film.awards)
                    .font(.subheadline)
                Text("Box office: \(film.boxOffice)")
                    .font(.subheadline)
            }
            .accessibilityElement(children: .combine)
    }
}


fileprivate struct RatingsVGrid: View {
    var film: Film
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(
                rows: [GridItem()],
                spacing: 10
            ) {
                ForEach(film.ratings) { rating in
                    ColouredVPadder(
                        backgroundColour: .purple,
                        cornerRadius: 12) {
                            Text(rating.source)
                                .fontWeight(.medium)
                            Text(rating.value)
                                .fontWeight(.bold)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityAddTraits(.isStaticText)
                        .accessibilityLabel(Text("\(rating.source) rate. \(rating.value)"))
                }
            }
        }
    }
}
