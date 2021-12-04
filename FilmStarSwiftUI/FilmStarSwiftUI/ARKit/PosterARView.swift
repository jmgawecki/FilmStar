//
//  PosterARView.swift.swift
//  FilmStarSwiftUI
//
//  Created by Jakub Gawecki on 04/12/2021.
//

import RealityKit
import ARKit


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
        
        button.addTarget(self, action: #selector(resetSession), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    var viewModel: FSViewModel
    let coachingOverlay = ARCoachingOverlayView()
    var arPoster: ARPoster?
    var isPlaced = false
    
    
    // MARK: - Init
    required init(viewModel: FSViewModel) {
        if let arResource = viewModel.film?.arResource {
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
        
        // TEST
        
        
    }
    
    func configureUI() {
        addSubview(resetSessionButton)
        
        NSLayoutConstraint.activate([
            resetSessionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            resetSessionButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
