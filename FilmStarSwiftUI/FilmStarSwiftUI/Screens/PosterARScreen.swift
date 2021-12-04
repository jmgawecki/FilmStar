import SwiftUI
import RealityKit

struct PosterARScreen: View {
    @ObservedObject var viewModel: SearchScreenViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ARViewContainer(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
            
            if !viewModel.isCoachingActive {
                FSBorederedButton(
                    title: "Back",
                    systemImage: "xmark",
                    colour: .purple,
                    size: .large) {
                        viewModel.isARPresenting.toggle()
                    }
                    .padding()
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: SearchScreenViewModel
    
    func makeUIView(context: Context) -> ARView {
        let arView = PosterARView(viewModel: viewModel)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
