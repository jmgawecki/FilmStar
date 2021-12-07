//
//  PosterARView+ARSessionDelegates.swift
//  FilmStarSwiftUI
//
//  Created by Jakub Gawecki on 04/12/2021.
//

import Foundation
import ARKit

extension PosterARView: ARSessionDelegate {
    
    /// Prevents Session from attempting relocalisation
    ///
    /// If a user will get too far from the starting point without properly tracked Scene, or a session will be interrupted in the middle, AR Experience will start all over again and will not ask user to go back to the original location
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        false
    }
}
