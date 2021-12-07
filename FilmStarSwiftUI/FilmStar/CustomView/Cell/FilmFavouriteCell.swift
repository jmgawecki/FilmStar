import SwiftUI

struct FilmFavouriteCell: View {
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


