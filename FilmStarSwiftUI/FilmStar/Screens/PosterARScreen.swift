import SwiftUI
import RealityKit

struct PosterARScreen: View {
    @ObservedObject var viewModel: FSViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ARViewContainer(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
            
            if !viewModel.isCoachingActive {
                FSBorederedButton(
                    title: "Back",
                    systemImage: "xmark",
                    colour: .purple,
                    size: .large,
                    accessibilityLabel: "Go back") {
                        viewModel.isARPresenting.toggle()
                    }
                    .padding()
            }
        }
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
