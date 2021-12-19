import SwiftUI

struct SearchScreen: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @ObservedObject var viewModel: FSViewModel
    @AccessibilityFocusState var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            if verticalSizeClass == .regular {
                VStack(spacing: 20) {
                    Spacer(minLength: 75)
                    
                    Image(decorative: FSImage.logoSearchScreen)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(20)
                        .padding(.bottom)
                    
                    FetchingErrorView(viewModel: viewModel)
                    
                    SearchFilmTextField(viewModel: viewModel)
                        .accessibilityFocused($isTextFieldFocused)
                    
                    SearchButtonsPanel(viewModel: viewModel)
                        .disabled(viewModel.isSearchTextFieldEmpty)
                    
                    FSRecentFilmsCollection(viewModel: viewModel)
                        .frame(
                            width: UIScreen.main.bounds.size.width - 50,
                            height: UIScreen.main.bounds.size.height * 0.40 )
                        .cornerRadius(20)
                        .accessibilitySortPriority(7)
                }
            } else {
                HStack(spacing: 20) {
                    FSRecentFilmsCollection(viewModel: viewModel)
                        .frame(
                            width: UIScreen.main.bounds.size.width * 0.45)
                        .cornerRadius(20)
                        .accessibilitySortPriority(7)
                    VStack {
                        FetchingErrorView(viewModel: viewModel)
                        
                        Image(decorative: FSImage.logoSearchScreen)
                            .resizable()
                            .frame(
                                minWidth: 40, idealWidth: 150,
                                maxWidth: 150, minHeight: 40,
                                idealHeight: 150, maxHeight: 150
                            )
                            .cornerRadius(20)
                        
                        SearchFilmTextField(viewModel: viewModel)
                        
                        SearchButtonsPanel(viewModel: viewModel)
                            .disabled(viewModel.isSearchTextFieldEmpty)
                    }
                }
            }
        }
        .onDisappear(perform: {
            self.isTextFieldFocused = false 
        })
        .overlay {
            if viewModel.isFetchingFilms {
                ProgressView()
                    .scaledToFill()
                    .tint(.purple)
                    .scaleEffect(2)
                    
            }
        }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchScreen(viewModel: FSViewModel())
                .previewInterfaceOrientation(.landscapeRight)
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
    @ObservedObject var viewModel: FSViewModel
    @State private var animationAngle: Double = 0
    @AccessibilityFocusState var isScreenFocused: Bool
    var body: some View {
        ZStack(alignment: .trailing) {
            Color.secondary
                .opacity(0.2)
                .cornerRadius(12)
                .frame(width: 360, height: 44)
            
            TextField(FSString.textFieldPlaceholder, text: $viewModel.searchFilmScreenText)
                .frame(width: 300, height: 44)
                .padding(.horizontal)
                .padding(.leading)
                .foregroundColor(Color.purple)
                .cornerRadius(12)
                .accessibilitySortPriority(10)
                .accessibilityFocused($isScreenFocused)
            
            Image(systemName: SFSymbol.settings)
                .rotationEffect(.degrees(animationAngle))
                .animation(.easeIn, value: animationAngle)
                .padding()
                .accessibilityLabel(VoiceOver.searchFilterSettings)
                .accessibilityHint(VoiceOver.doubleTapForFilterSettingsHint)
                .accessibilityRemoveTraits(.isImage)
                .accessibilityAddTraits(.isButton)
                .accessibilitySortPriority(9)
                .accessibilityRemoveTraits(.isImage)
                .accessibilityAddTraits(.isButton)
                .accessibilityIdentifier("filterButton")
                .onTapGesture {
                    animationAngle += 360
                    viewModel.isChangingFilters = true
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isScreenFocused = true
            }
        }
        .fullScreenCover(isPresented: $viewModel.isChangingFilters, content: {
            SearchFiltersScreen(viewModel: viewModel)
        })
    }
}

fileprivate struct SearchButtonsPanel: View {
    @ObservedObject var viewModel: FSViewModel
    
    var body: some View {
        HStack {
            FSButton(
                title: Description.searchForOne,
                systemImage: SFSymbol.film,
                colour: .fsSecondary,
                size: .large,
                accessibilityHint: VoiceOver.doubleTapForOneFilmSearch) {
                    viewModel.searchingError = nil
                    viewModel.fetchFilm(with: viewModel.searchFilmScreenText)
                    withAnimation {
                        viewModel.isFetchingFilms = true
                    }
                }
                .buttonStyle(.bordered)
                .accessibilitySortPriority(9)
            
            FSButton(
                title: Description.searchForMany,
                systemImage: SFSymbol.listOfFilms,
                colour: .purple,
                size: .large,
                accessibilityHint: VoiceOver.doubleTapForList) {
                    viewModel.searchingError = nil
                    viewModel.fetchListOfFilms(with: viewModel.searchFilmScreenText)
                    withAnimation {
                        viewModel.isFetchingFilms = true
                    }
                }
                .buttonStyle(.bordered)
                .accessibilitySortPriority(8)
        }
    }
}
