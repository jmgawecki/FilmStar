import SwiftUI

struct FilmsSearchCollectionScreen: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @ObservedObject var viewModel: FSViewModel
    @AccessibilityFocusState var isViewFocused: Bool
    
    var body: some View {
        VStack {
            if verticalSizeClass == .compact {
                Spacer(minLength: 20)
            }
            
            FilmSearchCollectionTopBar(
                viewModel: viewModel,
                isViewFocused: _isViewFocused
            )
            
            List {
                ForEach(viewModel.listOfTeasers) { filmTeaser in
                    FilmsSearchCollectionCell(filmTeaser: filmTeaser)
                        .onTapGesture {
                            viewModel.fetchFilm(with: filmTeaser.imdbID)
                        }
                }
            }
            .fullScreenCover(item: $viewModel.film, content: { _ in
                FilmDetailsScreen(viewModel: viewModel)
            })
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isViewFocused.toggle()
            }
        }
        
    }
}

struct FilmsListScreen_Previews: PreviewProvider {
    static var previews: some View {
        FilmsSearchCollectionScreen(viewModel: FSViewModel())
    }
}

fileprivate struct FilmSearchCollectionTopBar: View {
    @ObservedObject var viewModel: FSViewModel
    @AccessibilityFocusState var isViewFocused: Bool
    
    var body: some View {
        HStack {
            Text(FSString.resultsForTheSearch)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .padding(.leading)
                .minimumScaleFactor(0.5)
                .accessibilityLabel(VoiceOver.resultsForTheSearch)
                .accessibilityAddTraits(.isHeader)
                .accessibilityHint(VoiceOver.swipeRightForResultsHint)
                .accessibilityFocused($isViewFocused)
            
            Spacer()
            
            FSBorederedButton(
                systemImage: SFSymbol.close,
                colour: .yellow,
                size: .large,
                accessibilityLabel: VoiceOver.goBack,
                accessibilityHint: FSAccessibilityString.doubleTapToBackOrSwipeRight) {
                    withAnimation {
                        viewModel.listOfTeasers.removeAll()
                    }
                }
                .padding(.horizontal)
        }
    }
}

fileprivate struct FilmsSearchCollectionCell: View {
    var filmTeaser: FilmTeaser
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                FSImageView(urlString: filmTeaser.posterUrl)
                    .scaledToFit()
                    .frame(width: 60)
                    .cornerRadius(12)
                
                VStack(alignment: .leading) {
                    Text("\(filmTeaser.title) (\(filmTeaser.year))")
                        .font(.subheadline)
                }
                Spacer()
            }
            .accessibilityHidden(true)
            
        }
        .frame(width: 350, height: 130, alignment: .center)
        .cornerRadius(15)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(filmTeaser.title). Released in \(filmTeaser.year)")
        .accessibilityHint(VoiceOver.doubleTapForFilmDetails)
        .contentShape(Rectangle())
        .accessibilitySortPriority(9)
    }
}
