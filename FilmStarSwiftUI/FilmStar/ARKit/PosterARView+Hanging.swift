import RealityKit
import ARKit

extension PosterARView {
    // MARK: - RayCast and Hanging
    /// Performs RayCasting, searches for vertical plane. If such plane has been found, it renders an ARPoster onto it.
    /// - Parameter recogniser: Tap gesture on the screen.
    @objc
    func performHanging() {
        if let firstResult = raycastCentreView(),
           let _ = arPoster {
            placePoster(at: firstResult)
        }
    }
    
    /// Places or rehangs the poster
    ///
    /// When placing a poster for the first time, method uses raycast's result to get the transform. This transform is further modified by 10 cm on the positive z axe to avoid hiccups with the FocusSquare rendering.
    ///
    /// Before the placement, `ARPosters`'s `z` axe is set 5 meters from the destination and the move is animated towards the destination
    func placePoster(at raycastResult: ARRaycastResult) {
        // toTransform represents where the poster will animate to
        var toTransform = Transform(matrix: raycastResult.worldTransform)
        toTransform.translation.z += 0.1
        if !isPosterHang {
            posterAnchor = AnchorEntity(world: toTransform.matrix)
            arPoster = ARPoster(with: arResource)
            
             self.installGestures(
                 [.rotation, .scale],
                 for: arPoster! as HasCollision
             )
            
            var fromTransform = toTransform
            fromTransform.translation.z += 5
            arPoster?.transform = fromTransform
            
            posterAnchor!.addChild(arPoster!)
            scene.addAnchor(posterAnchor!)
            
            // animate towards where it should be hang
            arPoster?.move(to: toTransform, relativeTo: nil, duration: 1)

            resetSessionButton.setTitle("Rehang!", for: .normal)
            isPosterHang.toggle()
        } else {
            posterAnchor?.move(to: toTransform, relativeTo: nil, duration: 1)
        }
    }
    
    /// Performs the raycast on the middle of the phone's view
    func raycastCentreView() -> ARRaycastResult? {
        raycast(
            from: CGPoint.init(
                x: UIScreen.main.bounds.size.width * 0.5 ,
                y: UIScreen.main.bounds.size.height * 0.5),
            allowing: .estimatedPlane,
            alignment: .vertical
        ).first
    }
}
