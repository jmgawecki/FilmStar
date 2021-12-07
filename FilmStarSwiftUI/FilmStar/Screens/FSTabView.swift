import SwiftUI

struct FSTabView: View {
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    @ObservedObject var viewModel = FSViewModel()
    var body: some View {
        ZStack {
            TabView {
                SearchScreen(viewModel: viewModel)
                    .fullScreenCover(
                        isPresented: $viewModel.isShowingListOfFilms,
                        onDismiss: nil) {
                            FilmsSearchCollectionScreen(viewModel: viewModel)
                        }
                        .tabItem {
                            Text("Search")
                            Image(systemName: SFSymbol.search)
                        }
                
                FavouritesFilmsScreen(viewModel: viewModel)
                    .tabItem {
                        Text("Favourites")
                        Image(systemName: SFSymbol.favourites)
                    }
            }
            .fullScreenCover(isPresented: $shouldShowOnboarding, onDismiss: {
                print("Dismissed")
            }, content: {
                OnboardingTab(shouldPresentOnboarding: $shouldShowOnboarding)
            })
            .accentColor(Color.purple)
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

struct TabViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        FSTabView()
    }
}
