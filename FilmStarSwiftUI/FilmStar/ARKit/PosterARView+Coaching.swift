import ARKit

extension PosterARView: ARCoachingOverlayViewDelegate {
    /// Implements `ARCoachingOverlay` to instructs user on how to gather data about the Scene in order to improve the experience.
    func addCoachingOverlay() {
        coachingOverlay.delegate = self
        coachingOverlay.session = session
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .verticalPlane
        addSubview(coachingOverlay)
    }
}
