import SwiftUI

struct FavouritesFilmsView: View {
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
        List {
            ForEach(films.filter({ $0.isFavourite == true })) { film in
                FilmFavouriteCell(film: film)
                    .onTapGesture {
                        if let imdbID = film.imdbID {
                            viewModel.fetchFilm(with: imdbID)
                        }
                    }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { films[$0] }.forEach(viewContext.delete)
            
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
        FavouritesFilmsView(viewModel: FSViewModel())
    }
}
