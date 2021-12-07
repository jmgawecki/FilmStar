//
//  PosterARView.swift.swift
//  FilmStarSwiftUI
//
//  Created by Jakub Gawecki on 04/12/2021.
//

import RealityKit
import ARKit


/// PosterARView is a subclass of `ARView` to project an experience of "hanging" the `ARPoster` onto the vertical plane of any type
///
/// When tap gesture is being recognised, ARView performs RayCast to check if any plane has been detected and can be used as an Anchor.
///
/// Upon the successfull RayCast, a poster is being placed on the vertical plane
///
/// Session infroms the user if it has enough information about the scene. If it does not, it asks user to perform some action that may improve the experience.
///
/// With the reset button, the Session can be reset, and thus a user can go thorugh the experience again and hang the poster more precisely.
class PosterARView: ARView {
    // MARK: - UI
    private lazy var resetSessionButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedTinted()
        configuration.cornerStyle = UIButton.Configuration.CornerStyle.large
        configuration.title = "Reset"
        configuration.baseBackgroundColor = .yellow
        configuration.baseForegroundColor = .white
        configuration.image = UIImage(systemName: "restart")
        configuration.buttonSize = .large
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        
        button.addTarget(self, action: #selector(resetARSession), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    var viewModel: FSViewModel
    let coachingOverlay = ARCoachingOverlayView()
    var arPoster: ARPoster?
    var isPlaced = false
    
    
    // MARK: - Init
    required init(viewModel: FSViewModel) {
        if let arResource = viewModel.film?.arPosterTexture {
            arPoster = ARPoster(with: arResource)
        }
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureUI()
        session.delegate = self 
        addCoachingOverlay()
        configureSession()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recogniser:))))
    }
    
    @MainActor @objc required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    @MainActor @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - @Objc
    /// Performs RayCasting, searches for vertical plane. If such plane has been found, it renders an ARPoster onto it.
    /// - Parameter recogniser: Tap gesture on the screen.
    @objc
    func handleTap(recogniser: UITapGestureRecognizer) {
        if !isPlaced {
            let tapLocation = recogniser.location(in: self)
            
            let result = raycast(
                from: tapLocation,
                allowing: .estimatedPlane,
                alignment: .vertical
            )
            
            if let firstResult = result.first,
               let arPoster = arPoster {
                let coordinates = simd_make_float3(firstResult.worldTransform.columns.3)
                placePoster(arPoster, at: coordinates)
            }
        }
    }
    
    // MARK: - Logic
    func placePoster(_ poster: ARPoster, at location: SIMD3<Float>) {
        let posterAnchor = AnchorEntity(world: location)
        
        posterAnchor.addChild(poster)
        
        scene.addAnchor(posterAnchor)
        isPlaced.toggle()
    }
    
    func configureUI() {
        addSubview(resetSessionButton)
        
        NSLayoutConstraint.activate([
            resetSessionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            resetSessionButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
