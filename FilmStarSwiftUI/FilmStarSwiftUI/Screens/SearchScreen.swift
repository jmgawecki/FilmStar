import SwiftUI

struct SearchScreen: View {
    @State private var searchText = ""
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
                
                TextField("Search for film..", text: $viewModel.searchText)
                    .frame(width: 300, height: 44)
                    .padding(.horizontal)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .accessibilitySortPriority(10)
                
                FSBorederedButton(
                    title: "Search",
                    systemImage: SFSymbol.film,
                    colour: .purple,
                    size: .large) {
                        viewModel.fetchFilm(with: viewModel.searchText)
                    }
                    .accessibilitySortPriority(9)
                
                RecentSearchView(viewModel: viewModel)
                    .frame(
                        width: UIScreen.main.bounds.size.width - 50,
                        height: UIScreen.main.bounds.size.height * 0.40 )
                    .cornerRadius(20)
                    .accessibilitySortPriority(8)
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
