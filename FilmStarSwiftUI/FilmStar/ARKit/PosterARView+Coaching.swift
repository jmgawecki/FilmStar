//
//  PosterARView+Coaching.swift
//  FilmStarSwiftUI
//
//  Created by Jakub Gawecki on 04/12/2021.
//

import ARKit

extension PosterARView: ARCoachingOverlayViewDelegate {
    func addCoachingOverlay() {
        coachingOverlay.delegate = self
        coachingOverlay.session = session
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .verticalPlane
        addSubview(coachingOverlay)
    }
    
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        viewModel.isCoachingActive.toggle()
    }
    
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        viewModel.isCoachingActive.toggle()
    }
}
