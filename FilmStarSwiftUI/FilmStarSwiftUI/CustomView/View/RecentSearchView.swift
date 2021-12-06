import SwiftUI
import CoreData

struct RecentSearchView: View {
    @ObservedObject var viewModel: FSViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FSFilmSum.timestamp, ascending: false)],
        animation: .default
    )
    
    private var films: FetchedResults<FSFilmSum>
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [GridItem()]) {
                    ForEach(films) { film in
                        FilmRecentCell(film: film)
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
        RecentSearchView(viewModel: FSViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


