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
        configuration.title = "Scanning.."
        configuration.baseBackgroundColor = .yellow.withAlphaComponent(0.70)
        configuration.baseForegroundColor = .black
        configuration.image = UIImage(systemName: "paintpalette")
        configuration.buttonSize = .large
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        button.addTarget(self, action: #selector(performHanging), for: .touchUpInside)
        return button
    }()
    
    var focusSquare: FocusSquare?
    
    var arPoster: ARPoster? {
        didSet {
            if arPoster != nil, oldValue == nil {
                resetSessionButton.setTitle("Hang again!", for: .normal)
            }
        }
    }
   
    var posterAnchor: AnchorEntity?
    var focusSquareAnchor: AnchorEntity?
    
    // MARK: - Properties
    var viewModel: FSViewModel
    let coachingOverlay = ARCoachingOverlayView()
    var isFocusSquareAnchored: Bool = false
    var isPosterHang: Bool = false
    var arResource: TextureResource
    var focusBoxRendererCounter: Int = 2 {
        didSet {
            if focusBoxRendererCounter == 2000 {
                focusBoxRendererCounter /= 1000
            }
        }
    }
    
    static let isARExperienceAvailable: Bool = ARWorldTrackingConfiguration.supportsFrameSemantics([.personSegmentationWithDepth, .sceneDepth]) && ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification)
    
    
    // MARK: - Init
    @MainActor required init(viewModel: FSViewModel) {
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
    
    // MARK: - Layout UI
    func configureUI() {
        addSubview(resetSessionButton)
        
        NSLayoutConstraint.activate([
            resetSessionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            resetSessionButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
