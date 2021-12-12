import RealityKit
import ARKit
import SwiftUI

/**
 PosterARView is a subclass of `ARView` to project an experience of "hanging" the `ARPoster` onto the vertical plane of any type

Upon the tapping the button, ARView performs RayCast to check if any plane has been detected and can be used as an Anchor.

Upon the successfull RayCast, a poster is being placed on the vertical plane

Session infroms the user if it has enough information about the scene. If it does not, it asks user to perform some action that may improve the experience.

Please note that the experience is possible only for devices with LiDAR Scanner.
*/
class PosterARView: ARView {
    // MARK: - UI
    lazy var resetSessionButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = UIButton.Configuration.CornerStyle.large
        configuration.title = "Hang it!"
        configuration.baseBackgroundColor = .yellow.withAlphaComponent(0.70)
        configuration.baseForegroundColor = .black
        configuration.image = UIImage(systemName: "paintpalette")
        configuration.buttonSize = .large
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        button.addTarget(self, action: #selector(performHanging), for: .touchUpInside)
        return button
    }()
    
    var arPoster: ARPoster?
    let focusSquare: FocusSquare?
    var posterAnchor: AnchorEntity?
    var focusSquareAnchor: AnchorEntity?
    
    // MARK: - Properties
    var viewModel: FSViewModel
    let coachingOverlay = ARCoachingOverlayView()
    var isFocusSquareAnchored: Bool = false
    var arResource: TextureResource
    
    static let isARExperienceAvailable: Bool = ARWorldTrackingConfiguration.supportsFrameSemantics([.personSegmentationWithDepth, .sceneDepth]) && ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification)
    
    
    // MARK: - Init
    required init(viewModel: FSViewModel) {
        /// No nil possible since the View would be never initialised otherwise
        self.arResource = viewModel.film!.arPosterTexture!
        focusSquare = FocusSquare(textureResource: arResource)
        arPoster = ARPoster(with: arResource)
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureUI()
        session.delegate = self
        addCoachingOverlay()
        configureSession()
    }
    
    @MainActor @objc required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    @MainActor @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - RayCast and Hanging
    /// Performs RayCasting, searches for vertical plane. If such plane has been found, it renders an ARPoster onto it.
    /// - Parameter recogniser: Tap gesture on the screen.
    @objc
    func performHanging() {
        let result = raycast(
            from: CGPoint.init(x: UIScreen.main.bounds.size.width * 0.5 , y: UIScreen.main.bounds.size.height * 0.5),
            allowing: .estimatedPlane,
            alignment: .vertical
        )
        
        if let firstResult = result.first,
           let _ = arPoster {
            let coordinates = simd_make_float3(firstResult.worldTransform.columns.3)
            placePoster(at: coordinates)
        }
    }
    
    func placePoster(at location: SIMD3<Float>) {
        if let posterAnchor = posterAnchor {
            scene.removeAnchor(posterAnchor)
        }
        
        posterAnchor = nil
        posterAnchor = AnchorEntity(world: location)
        
        arPoster?.removeFromParent()
        arPoster = nil
        arPoster = ARPoster(with: arResource)
        
        self.installGestures(
            [.rotation, .scale],
            for: arPoster! as HasCollision
        )
        
        posterAnchor!.addChild(arPoster!)
        scene.addAnchor(posterAnchor!)
    }
    
    // MARK: - Layout UI
    func configureUI() {
        addSubview(resetSessionButton)
        
        NSLayoutConstraint.activate([
            resetSessionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            resetSessionButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
