import SwiftUI

struct FilmSumCell: View {
    let film = FilmMock.gogv2
    var body: some View {
        ZStack {
            HStack {
                Image(decorative: "LogoSearchScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .cornerRadius(10)
                    .padding(.top)
                VStack(alignment: .leading) {
                    Text(film.title)
                        .font(.subheadline)
                        .accessibilityAddTraits(.isHeader)
                    Text(film.genre)
                        .font(.callout)
                    Text("Directed by \(film.director)")
                        .font(.caption)
                }
                .accessibilityHidden(true)
                .multilineTextAlignment(.leading)
            }
            .frame(height: 100)
        }
        .accessibilityElement(children: .combine)
        .accessibilityCustomContent(.title, film.title, importance: .high)
        .accessibilityCustomContent(.genre, film.genre)
        .accessibilityCustomContent(.director, "Directed by \(film.director)", importance: .high)
        .accessibilityHint("Double tap to go to Film's full details")
    }
}

