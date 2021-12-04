import SwiftUI

struct FilmSumView: View {
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
                    Text("By \(film.director)")
                        .font(.caption)
                }
                .multilineTextAlignment(.leading)
            }
            .frame(height: 100)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(Text(film.title))
        .accessibilityHint("Double tap to go to Film's full details")
    }
}
