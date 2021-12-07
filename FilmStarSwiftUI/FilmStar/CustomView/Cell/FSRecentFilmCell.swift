import SwiftUI

/// `FSRecentFilmCell` is used to present films saved by the user to its favourites. Struct uses `FSRecentFilmsCollection` CoreData model for displaying.
///
/// Struct's accessibility has been adjusted and currently reads title and the director only. Structs provides instruction for users with accessibility enabled.
struct FSRecentFilmCell: View {
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
                    Text(film.title ?? "Title unknown")
                        .font(.title3)
                        .accessibilityAddTraits(.isHeader)
                    Text(film.genre ?? "Genre unknown")
                        .font(.callout)
                    Text("Directed by \(film.director ?? "")")
                        .font(.caption)
                }
                .foregroundColor(.purple)
                .accessibilityHidden(true)
                .multilineTextAlignment(.leading)
                .padding(.leading)
                Spacer()
            }
        }
        .frame(width: 350, height: 130, alignment: .center)
        .cornerRadius(15)
        .accessibilityElement(children: .combine)
        .accessibilityCustomContent(.title, film.title ?? "unknown", importance: .high)
        .accessibilityCustomContent(.genre, film.genre ?? "unknown")
        .accessibilityCustomContent(.director, "Directed by \(film.director ?? "unknown")", importance: .high)
        .accessibilityHint("Swipe down for more details or double tap to go to Film's full details")
    }
}

