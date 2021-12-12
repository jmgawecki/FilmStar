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
        if let raycastResult = raycastCentreView(),
           let focusSquare = focusSquare {
            if !isFocusSquareAnchored {
                focusSquareAnchor = AnchorEntity(raycastResult: raycastResult)
                focusSquareAnchor?.addChild(focusSquare)
                scene.addAnchor(focusSquareAnchor!)
                isFocusSquareAnchored.toggle()
            } else {
                focusSquare.move(to: raycastResult.worldTransform, relativeTo: nil)
            }
        }
    }
    
    func raycastCentreView() -> ARRaycastResult? {
        raycast(
            from: CGPoint.init(
                x: UIScreen.main.bounds.size.width * 0.5 ,
                y: UIScreen.main.bounds.size.height * 0.5),
            allowing: .estimatedPlane,
            alignment: .any
        ).first
    }
}
