import Foundation
import ARKit

extension PosterARView {
    /// Configures Session by implementing `ARWorldTrackingConfiguration`
    ///
    /// Experience is largery improved when using an iOS device with the built-in LiDAR scanner.
    func configureSession() {
        let configuration = ARWorldTrackingConfiguration()
        guard
            PosterARView.isARExperienceAvailable
        else { return }
        configuration.frameSemantics = [.personSegmentationWithDepth, .sceneDepth]
        configuration.planeDetection = [.vertical]
        configuration.sceneReconstruction = .meshWithClassification
        configuration.environmentTexturing = .automatic
        session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
}
