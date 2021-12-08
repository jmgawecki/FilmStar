import SwiftUI

struct FSTabView: View {
    @AppStorage(FSOperationalString.appStorageShouldShowOnboarding) var shouldShowOnboarding: Bool = true
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
                            Text(Description.search)
                            Image(systemName: SFSymbol.search)
                        }
                
                FavouritesFilmsScreen(viewModel: viewModel)
                    .tabItem {
                        Text(Description.favourites)
                        Image(systemName: SFSymbol.favourite)
                    }
            }
            .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
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
