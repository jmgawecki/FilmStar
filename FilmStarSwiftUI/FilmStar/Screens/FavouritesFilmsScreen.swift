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
                        .accessibilityHint("Swipe right to get to the list of your favourite Films.")
                    List {
                        ForEach(films.filter({ $0.isFavourite == true })) { film in
                            FilmFavouriteCell(film: film)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if let imdbID = film.imdbID {
                                        viewModel.fetchFilm(with: imdbID)
                                    }
                                }
                        }
                        .onDelete(perform: removeFavouriteFilm)
                        .accessibilityFocused($isScreenFocused)
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
