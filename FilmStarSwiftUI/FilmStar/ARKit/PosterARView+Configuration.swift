import Foundation
import ARKit

extension PosterARView {
    
    /// Configures Session by implementing `ARWorldTrackingConfiguration`
    ///
    /// Experience is largery improved when using an iOS device with the built-in LiDAR scanner.
    func configureSession() {
        let configuration = ARWorldTrackingConfiguration()
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth),
           ARWorldTrackingConfiguration.supportsFrameSemantics(.sceneDepth) {
            configuration.frameSemantics = [.personSegmentationWithDepth, .sceneDepth]
        }
        configuration.planeDetection = [.vertical]
        configuration.environmentTexturing = .automatic
        session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
    
    /// Resets the current session and configures a new one.
    @objc
    func resetARSession() {
        isPlaced = false
        scene.anchors.removeAll()
        configureSession()
    }
}
