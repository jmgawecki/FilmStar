import SwiftUI

struct SearchFiltersScreen: View {
    @ObservedObject var viewModel: FSViewModel
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text(Description.searchFilters)) {
                        Picker("Type", selection: $viewModel.typeIndex) {
                            ForEach(0..<viewModel.searchTypes.count) {
                                Text(viewModel.searchTypes[$0])
                            }
                        }
                        
                        Picker("Year", selection: $viewModel.year) {
                            ForEach(0..<viewModel.searchYears.count, id: \.self) {
                                Text(String(viewModel.searchYears[$0])).tag($0)
                            }
                        }
                    }
                }
                HStack {
                    FSBorederedButton(
                        title: Description.resetSettings,
                        systemImage: SFSymbol.restart,
                        colour: .red,
                        size: .large,
                        isAnimated: true,
                        accessibilityLabel: Description.resetSettings,
                        accessibilityHint: VoiceOver.doubleTapToRemoveFilters) {
                            viewModel.year = 0
                            viewModel.typeIndex = 0
                        }
                    
                    FSBorederedButton(
                        title: Description.done,
                        systemImage: SFSymbol.checkmark,
                        colour: .green,
                        size: .large,
                        accessibilityLabel: Description.done,
                        accessibilityHint: VoiceOver.doubleTapToConfirmSettings) {
                            viewModel.isChangingFilters = false
                        }
                }
                .padding(.top, 30)
            }
        }
    }
}

struct SearchParametersScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchFiltersScreen(viewModel: FSViewModel())
.previewInterfaceOrientation(.landscapeRight)
    }
}
