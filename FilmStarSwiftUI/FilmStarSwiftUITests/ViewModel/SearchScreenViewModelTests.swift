import XCTest
import RealityKit
@testable import FilmStarSwiftUI

class SearchScreenViewModelTests: XCTestCase {
    
    func testFetchingFilmWillSucceed() async throws {
        // Arrange and Act
        let film = try await NetworkManager.shared.fetchFilm(fetchBy: .id, with: "tt3896198")
        
        // Assert
        XCTAssertEqual(film?.imdbID, FilmMock.gogv2.imdbID)
    }
    
    func testFetchingPosterWillSucceed() async throws {
        // Arrange
        let film = FilmMock.gogv2
        
        // Act
        let data = try await NetworkManager.shared.fetchPosterData(with: film.posterUrl)
        
        // Assert
        XCTAssertNotNil(data)
    }
    
    func testFetchingPosterDataForGuardiansAncCreatingUIImageWillSucceed() async throws {
        // Arrange
        var film = FilmMock.gogv2
        
        // Act
        let data = try await NetworkManager.shared.fetchPosterData(with: film.posterUrl)
        if let data = data {
            
            // Main Dispatch needed for UI changes
            film.posterImage = UIImage(data: data)
            
            // Assert
            XCTAssertNotNil(film.posterImage)
        }
    }
    
    func testFetchingPosterDataForGuardiansAndCreatingTextureResourcesWillSucceed() async throws {
        // Arrange
        let film = FilmMock.gogv2
        
        // Act
        let data = try await NetworkManager.shared.fetchPosterData(with: film.posterUrl)
        if let data = data {
            
            let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("posterTexureResource")
            try? data.write(to: filePath)
            DispatchQueue.main.async {
                let arResource = try? TextureResource.load(contentsOf: filePath)
                // Assert
                XCTAssertNotNil(arResource)
            }
        }
    }
}
