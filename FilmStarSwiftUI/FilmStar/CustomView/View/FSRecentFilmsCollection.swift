import SwiftUI
import CoreData


/// `FSRecentFilmsCollection` manages displaying films that user has saved to its favourites with `FSRecentFilmCell`. Films are being fetched from CoreData Model.
struct FSRecentFilmsCollection: View {
    @ObservedObject var viewModel: FSViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \FSFilmSum.timestamp,
                ascending: false
            )
        ],
        animation: .default
    ) private var films: FetchedResults<FSFilmSum>
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [GridItem()]) {
                    ForEach(films) { film in
                        FSRecentFilmCell(film: film)
                            .onTapGesture {
                                if let imdbID = film.imdbID {
                                    viewModel.fetchFilm(with: imdbID)
                                }
                            }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FSRecentFilmsCollection(viewModel: FSViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


