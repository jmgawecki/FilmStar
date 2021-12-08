import SwiftUI

class FSSearchParameters: ObservableObject {
    var searchTypes = ["Any", "Movie", "Series", "Episode"]
    var searchYears: [Int] = Array<Int>(1888...2021).reversed()
    
    @Published var year = 0
    @Published var typeIndex = 0
}

struct SearchParametersScreen: View {
    @ObservedObject var searchParameters = FSSearchParameters()
    @ObservedObject var viewModel: FSViewModel
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Search parameters")) {
                        Picker("Type", selection: $viewModel.typeIndex) {
                            ForEach(0..<viewModel.searchTypes.count) {
                                Text(viewModel.searchTypes[$0])
                            }
                        }
                        
                        Picker("Year", selection: $viewModel.year) {
                            ForEach(0..<viewModel.searchYears.count) { index in
                                Text(String(viewModel.searchYears[index]))
                            }
                        }
                    }
                }
                HStack {
                    FSBorederedButton(
                        title: "Reset settings",
                        systemImage: "restart.circle",
                        colour: .red,
                        size: .large,
                        isAnimated: true,
                        accessibilityLabel: "Reset settings",
                        accessibilityHint: "Double tap to remove all the filters from the search") {
                            viewModel.year = 0
                            viewModel.typeIndex = 0
                        }
                    
                    FSBorederedButton(
                        title: "Done",
                        systemImage: "checkmark",
                        colour: .green,
                        size: .large,
                        accessibilityLabel: "Done",
                        accessibilityHint: "Double tap to confirm settings and go back.") {
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
        SearchParametersScreen(viewModel: FSViewModel())
    }
}
