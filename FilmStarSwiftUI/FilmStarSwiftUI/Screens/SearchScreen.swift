import SwiftUI

struct SearchScreen: View {
    @State private var searchText = ""
    @ObservedObject var viewModel = SearchScreenViewModel()
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                
                
                    Image("LogoSearchScreen")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(20)
                        .padding(.bottom)

                
                
                TextField("Search for film..", text: $searchText)
                    .frame(width: 300, height: 44)
                    .padding(.horizontal)
                    .overlay(Capsule(style: .continuous)
                                .stroke(Color.black, lineWidth: 2))
                
                FSBorederedButton(
                    title: "Search",
                    systemImage: SFSymbol.film,
                    colour: .purple,
                    size: .large) {
                        viewModel.fetchFilm(with: searchText)
                    }
                
                ContentView()
                    .frame(
                        width: UIScreen.main.bounds.size.width - 50,
                        height: UIScreen.main.bounds.size.height * 0.40 )
                    .cornerRadius(20)
            }
        }
                .fullScreenCover(
                    item: $viewModel.film,
                    onDismiss: {
                        viewModel.film?.posterImage = nil
                    },
                    content: { film in
                        FilmDetailsScreen(viewModel: viewModel)
                    }
                )
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchScreen()
            SearchScreen()
                .preferredColorScheme(.dark)
        }
    }
}
