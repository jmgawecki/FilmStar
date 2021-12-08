import SwiftUI

struct SearchScreen: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @ObservedObject var viewModel: FSViewModel
    
    var body: some View {
        ZStack {
            if verticalSizeClass == .regular {
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image(decorative: FSImage.logoSearchScreen)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(20)
                        .padding(.bottom)
                    
                    FetchingErrorView(viewModel: viewModel)
                    
                    SearchFilmTextField(viewModel: viewModel)
                    
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
        .popover(isPresented: $viewModel.isChangingFilters, content: {
            SearchFiltersScreen(viewModel: viewModel)
        })
    }
}

fileprivate struct SearchButtonsPanel: View {
    @ObservedObject var viewModel: FSViewModel
    
    var body: some View {
        HStack {
            FSBorederedButton(
                title: Description.luckyShot,
                systemImage: SFSymbol.dice,
                colour: .mint,
                size: .large,
                accessibilityHint: VoiceOver.doubleTapForOneFilmSearch) {
                    viewModel.searchingError = nil
                    viewModel.fetchFilm(with: viewModel.searchFilmScreenText)
                }
                .accessibilitySortPriority(9)
            
            FSBorederedButton(
                title: Description.getTheList,
                systemImage: SFSymbol.film,
                colour: .purple,
                size: .large,
                accessibilityHint: VoiceOver.doubleTapForList) {
                    viewModel.searchingError = nil
                    viewModel.fetchListOfFilms(with: viewModel.searchFilmScreenText)
                }
                .accessibilitySortPriority(8)
        }
    }
}
