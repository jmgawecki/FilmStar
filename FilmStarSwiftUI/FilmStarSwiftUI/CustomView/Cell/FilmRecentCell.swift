import SwiftUI

struct FilmRecentCell: View {
    var film: FSFilmSum
    var body: some View {
        ZStack {
            Color.purple
                .frame(width: 275, height: 80, alignment: .center)
                .cornerRadius(15)
            HStack {
                VStack(alignment: .leading) {
                    Text(film.title ?? "Title unknown")
                        .font(.title3)
                        .accessibilityAddTraits(.isHeader)
                    Text(film.genre ?? "Genre unknown")
                        .font(.callout)
                    Text("Directed by \(film.director ?? "")")
                        .font(.caption)
                }
                .accessibilityHidden(true)
                .multilineTextAlignment(.leading)
                .padding(.leading)
                Spacer()
            }
            .frame(width: 300, height: 100, alignment: .center)
            .background(.ultraThinMaterial)
            .cornerRadius(15)
        }
        .accessibilityElement(children: .combine)
        .accessibilityCustomContent(.title, "unknown", importance: .high)
        .accessibilityCustomContent(.genre, "unknown")
        .accessibilityCustomContent(.director, "Directed by \(film.director ?? "")", importance: .high)
        .accessibilityHint("Double tap to go to Film's full details")
    }
}

