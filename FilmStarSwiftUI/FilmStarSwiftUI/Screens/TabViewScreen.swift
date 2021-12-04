import SwiftUI

struct TabViewScreen: View {
    @ObservedObject var viewModel = FSViewModel()
    var body: some View {
        TabView {
            SearchScreen(viewModel: viewModel)
                .tabItem {
                    Text("Search")
                    Image(systemName: SFSymbol.search)
                }
                
            FavouritesFilmsView(viewModel: viewModel)
                .tabItem {
                    Text("Favourites")
                    Image(systemName: SFSymbol.favourites)
                }
        }
        .accentColor(Color.purple)
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

struct TabViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabViewScreen()
    }
}
