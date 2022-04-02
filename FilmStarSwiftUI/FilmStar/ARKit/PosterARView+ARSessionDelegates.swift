import Foundation
import ARKit
import RealityKit

extension PosterARView: ARSessionDelegate {
    /// Prevents Session from attempting relocalisation
    ///
    /// If a user will get too far from the starting point without properly tracked Scene, or a session will be interrupted in the middle, AR Experience will start all over again and will not ask user to go back to the original location
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        false
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        if focusBoxRendererCounter % 2 == 0 {
            if let raycastResult = raycastCentreView(),
               let focusSquare = focusSquare {
                if !isFocusSquareAnchored {
#if targetEnvironment(simulator)
                    focusSquareAnchor = AnchorEntity()
#else
                    focusSquareAnchor = AnchorEntity(raycastResult: raycastResult)
#endif
                    focusSquareAnchor?.addChild(focusSquare)
                    scene.addAnchor(focusSquareAnchor!)
                    resetSessionButton.setTitle("Hang it!", for: .normal)
                    resetSessionButton.configuration?.baseBackgroundColor = .green.withAlphaComponent(0.9)
                    resetSessionButton.configuration?.baseForegroundColor = .black
                    isFocusSquareAnchored.toggle()
                } else {
                    focusSquare.move(to: raycastResult.worldTransform, relativeTo: nil, duration: 0.5)
                }
            }
        }
        focusBoxRendererCounter += 1
    }
}
