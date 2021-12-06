//
//  PosterARView+ARSessionDelegates.swift
//  FilmStarSwiftUI
//
//  Created by Jakub Gawecki on 04/12/2021.
//

import Foundation
import ARKit

extension PosterARView: ARSessionDelegate {
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        false
    }
}
