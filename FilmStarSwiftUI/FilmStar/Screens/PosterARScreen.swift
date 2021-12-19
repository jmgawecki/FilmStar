import SwiftUI
import RealityKit

struct PosterARScreen: View {
    @ObservedObject var viewModel: FSViewModel
    @AppStorage(FSOperationalString.appStorageShouldShowAROnboarding) var shouldPresentAROnboarding: Bool = true
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if shouldPresentAROnboarding {
                AROnboardingTab(shouldPresentAROnboarding: $shouldPresentAROnboarding)
            } else {
                ARViewContainer(viewModel: viewModel)
                    .edgesIgnoringSafeArea(.all)
            
                    FSButton(
                        title: FSString.back,
                        systemImage: SFSymbol.close,
                        colour: .purple,
                        size: .large,
                        accessibilityLabel: FSAccessibilityString.goBack) {
                            viewModel.isPresentingARExperience.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        .opacity(0.85)
                        .padding()
            }

        }
    }
}


struct Preview_PosterARScreen: PreviewProvider {
    static var previews: some View {
        PosterARScreen(viewModel: FSViewModel())
    }
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: FSViewModel
    
    func makeUIView(context: Context) -> ARView {
        let arView = PosterARView(viewModel: viewModel)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
