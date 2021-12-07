import SwiftUI

struct FavouritesFilmsScreen: View {
    @AccessibilityFocusState var isScreenFocused: Bool {
        didSet {
            print(isScreenFocused)
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
        animation: .default) private var films: FetchedResults<FSFilmSum>
    
    @ObservedObject var viewModel: FSViewModel
    var body: some View {
        ZStack {
            if !films.isEmpty {
                VStack {
                    Text("Favourite Films")
                        .fontWeight(.bold)
                        .font(.title2)
                        .accessibilityFocused($isScreenFocused)
                        .accessibilityLabel("Favourite Films. Swipe right to get to the list of your favourite Films.")
                    List {
                        ForEach(films.filter({ $0.isFavourite == true })) { film in
                            FSFavouriteFilmCell(film: film)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if let imdbID = film.imdbID {
                                        viewModel.fetchFilm(with: imdbID)
                                    }
                                }
                        }
                        .onDelete(perform: removeFavouriteFilm)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isScreenFocused.toggle()
                        }
                    }
                }
            } else {
                Text("Your favourites are empty... go ahead and add some!")
            }
        }
    }
    
    private func removeFavouriteFilm(offsets: IndexSet) {
        withAnimation {
            offsets.map { films.filter({ $0.isFavourite == true })[$0] }.forEach({ $0.isFavourite = false })
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct FavouritesFilmsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesFilmsScreen(viewModel: FSViewModel())
    }
}

//MARK: - Fileprivate views
/// `FSFavouriteFilmCell` is used to present films saved by the user to its favourites. Struct uses `FSFilmSum` CoreData model for displaying.
///
/// Struct's accessibility has been adjusted and currently reads title and the director only. Structs provides instruction for users with accessibility enabled.
struct FSFavouriteFilmCell: View {
    var film: FSFilmSum
    var body: some View {
        ZStack {
            HStack {
                HStack {
                    if let imageUrl = film.posterUrl {
                        FSImageView(urlString: imageUrl)
                            .scaledToFit()
                            .frame(width: 60)
                            .cornerRadius(12)
                            .accessibility(hidden: true)
                    }
                    VStack(alignment: .leading) {
                        Text(film.title ?? "Title unknown")
                            .font(.title3)
                            .accessibilityAddTraits(.isHeader)
                        Text(film.genre ?? "Genre unknown")
                            .font(.callout)
                        Text("Directed by \(film.director ?? "")")
                            .font(.caption)
                    }
                    .foregroundColor(Color.purple)
                }
                .accessibilityHidden(true)
                .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .accessibilityElement(children: .combine)
            .accessibilityCustomContent(.title, film.title ?? "unknown", importance: .high)
            .accessibilityCustomContent(.genre, film.genre ?? "unknown")
            .accessibilityCustomContent(.director, "Directed by \(film.director ?? "unknown")", importance: .high)
            .accessibilityHint("Swipe down for more details or double tap to go to Film's full details")
        }
    }
}



