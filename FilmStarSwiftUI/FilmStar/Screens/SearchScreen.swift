import SwiftUI

struct SearchScreen: View {
    @ObservedObject var viewModel: FSViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                
                Image(decorative: "LogoSearchScreen")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .cornerRadius(20)
                    .padding(.bottom)
                
                FetchingErrorView(viewModel: viewModel)
                
                SearchFilmTextField(searchText: $viewModel.searchFilmScreenText)
                
                SearchButtonsPanel(viewModel: viewModel)
                    .disabled(viewModel.isSearchTextFieldEmpty)
                
                FSRecentFilmsCollection(viewModel: viewModel)
                    .frame(
                        width: UIScreen.main.bounds.size.width - 50,
                        height: UIScreen.main.bounds.size.height * 0.40 )
                    .cornerRadius(20)
                    .accessibilitySortPriority(7)
            }
        }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchScreen(viewModel: FSViewModel())
            SearchScreen(viewModel: FSViewModel())
                .preferredColorScheme(.dark)
        }
    }
}

fileprivate struct FetchingErrorView: View {
    @ObservedObject var viewModel: FSViewModel
    @State var isShowingError: Bool = false
    var body: some View {
        ZStack {
            if isShowingError {
                if let error = viewModel.searchingError {
                    Text(error)
                        .frame(width: 300, height: 50)
                        .font(.caption)
                        .foregroundColor(Color.red)
                }
            }
        }
        .onChange(of: viewModel.searchingError) { newValue in
            withAnimation {
                if newValue != nil {
                    isShowingError = true
                } else {
                    isShowingError = false
                }
            }
        }
    }
}

fileprivate struct SearchFilmTextField: View {
    @Binding var searchText: String
    var body: some View {
        ZStack {
            Color.secondary
                .opacity(0.2)
                .cornerRadius(12)
                .padding(.horizontal, 35)
            
            TextField("Search for film..", text: $searchText)
                .frame(width: 300, height: 44)
                .padding(.horizontal)
                .foregroundColor(Color.purple)
                .cornerRadius(12)
                .accessibilitySortPriority(10)
        }
    }
}

fileprivate struct SearchButtonsPanel: View {
    @ObservedObject var viewModel: FSViewModel
    
    var body: some View {
        HStack {
            FSBorederedButton(
                title: "Lucky shot",
                systemImage: "dice",
                colour: .mint,
                size: .large,
                accessibilityHint: "Double tap to search for one film.") {
                    viewModel.searchingError = nil
                    viewModel.fetchFilm(with: viewModel.searchFilmScreenText)
                }
                .accessibilitySortPriority(9)
            
            FSBorederedButton(
                title: "Get the list",
                systemImage: SFSymbol.film,
                colour: .purple,
                size: .large,
                accessibilityHint: "Double tap to search for the list of movies") {
                    viewModel.searchingError = nil
                    viewModel.fetchListOfFilms(with: viewModel.searchFilmScreenText)
                }
                .accessibilitySortPriority(8)
        }
    }
}
