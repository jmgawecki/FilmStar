import Foundation
import ARKit

extension PosterARView {
    
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
    
    @objc
    func resetSession() {
        isPlaced = false
        scene.anchors.removeAll()
        configureSession()
    }
}
