import Foundation
import ARKit

extension PosterARView {
    /// Configures Session by implementing `ARWorldTrackingConfiguration`
    ///
    /// ARSession will never be configured unless experience run on LiDAR based devices.
    func configureSession() {
        guard
            PosterARView.isARExperienceAvailable
        else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = [.personSegmentationWithDepth, .sceneDepth]
        configuration.planeDetection = [.vertical]
        configuration.sceneReconstruction = .meshWithClassification
        configuration.environmentTexturing = .automatic
        session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
}
