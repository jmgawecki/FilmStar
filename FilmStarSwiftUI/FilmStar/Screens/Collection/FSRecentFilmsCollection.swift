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

/// `FSRecentFilmCell` is used to present films saved by the user to its favourites. Struct uses `FSRecentFilmsCollection` CoreData model for displaying.
///
/// Struct's accessibility has been adjusted and currently reads title and the director only. Structs provides instruction for users with accessibility enabled.
fileprivate struct FSRecentFilmCell: View {
    var film: FSFilmSum
    var body: some View {
        ZStack {
            Color.purple
                .opacity(0.15)
            HStack {
                if let posterUrl = film.posterUrl {
                    FSImageView(urlString: posterUrl)
                        .scaledToFit()
                        .frame(minWidth: 60)
                        .cornerRadius(12)
                        .padding()
                }
                VStack(alignment: .leading) {
                    Text(film.title ?? Description.titleUnknown)
                        .font(.title3)
                        .accessibilityAddTraits(.isHeader)
                    Text(film.genre ?? Description.genreUnknown)
                        .font(.callout)
                    
                    if let director = film.director, director != "N/A" {
                        Text("Directed by \(film.director ?? "")")
                            .font(.caption)
                    }
                }
                .foregroundColor(.purple)
                .accessibilityHidden(true)
                .multilineTextAlignment(.leading)
                .padding(.leading)
                Spacer()
            }
        }
        .frame(minWidth: 250, idealWidth: 350, idealHeight: 130)
        .cornerRadius(15)
        .accessibilityElement(children: .combine)
        .accessibilityCustomContent(.title, film.title ?? VoiceOver.unknown, importance: .high)
        .accessibilityCustomContent(.genre, film.genre ?? VoiceOver.unknown)
        .accessibilityCustomContent(.director, "Directed by \(film.director ?? VoiceOver.unknown)", importance: .high)
        .accessibilityHint(VoiceOver.swipeDownForCellDetailsOrTapForFull)
    }
}

