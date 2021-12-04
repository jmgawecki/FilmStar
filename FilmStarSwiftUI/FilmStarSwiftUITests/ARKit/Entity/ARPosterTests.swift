//
//  ARPosterTests.swift
//  FilmStarSwiftUITests
//
//  Created by Jakub Gawecki on 04/12/2021.
//

import XCTest
import RealityKit
@testable import FilmStarSwiftUI

class ARPosterTests: XCTestCase {
    
    func testGeneratingPosterModelSucceeds() async throws {
        // Arrange
        let film = FilmMock.gogv2
        
        // Act
        let data = try await NetworkManager.shared.fetchPosterData(with: film.posterUrl)
        if let data = data {
            
            let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("posterTexureResource")
            try? data.write(to: filePath)
            DispatchQueue.main.async {
                let arResource = try? TextureResource.load(contentsOf: filePath)
                guard let arResource = arResource
                else { XCTFail(); return }
                var material = UnlitMaterial()
                material.baseColor = MaterialColorParameter.texture(arResource)
                material.tintColor = .white.withAlphaComponent(0.99)
                
                let posterModel = ModelComponent(
                    mesh: .generatePlane(
                        width: Float(0.5),
                        height: Float(0.5 * Float(arResource.width / arResource.height))
                    ),
                    materials: [material]
                )
                
                XCTAssertNotNil(posterModel)
            }
        }
    }
    
    func testRatioChecks() async throws {
        // Arrange
        let film = FilmMock.gogv2
        
        // Act
        let data = try await NetworkManager.shared.fetchPosterData(with: film.posterUrl)
        if let data = data {
            
            let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("posterTexureResource")
            try? data.write(to: filePath)
            DispatchQueue.main.async {
                let arResource = try? TextureResource.load(contentsOf: filePath)
                guard let arResource = arResource
                else { XCTFail(); return }
                var material = UnlitMaterial()
                material.baseColor = MaterialColorParameter.texture(arResource)
                material.tintColor = .white.withAlphaComponent(0.99)
                
                let posterModel = ModelComponent(
                    mesh: .generatePlane(
                        width: Float(0.5),
                        height: Float(0.5 * Float(arResource.height) / Float(arResource.width))
                    ),
                    materials: [material]
                )
                
                XCTAssertNotNil(posterModel)
            }
        }
    }
}
