import XCTest
import RealityKit
@testable import FilmStar

class SearchScreenViewModelTests: XCTestCase {
    // MARK: - Movie Fetching
    func testFetchingtt3896198WithfetchFilmMethodSucceeds() async throws {
        do {
            let film = try await NetworkManager.shared.fetchFilm(fetchBy: .id, with: "tt3896198", type: "Any", year: "Any")
            if let film = film {
                XCTAssertEqual(film.imdbID, "tt3896198")
            } else {
                XCTFail()
            }
        } catch let error as FSFilmFetchingError {
            XCTFail(error.rawValue)
        }
    }
    
    func testFetchingGuardiansWithTitleWithfetchFilmMethodSucceeds() async throws {
        do {
            let film = try await NetworkManager.shared.fetchFilm(fetchBy: .title, with: "Guardians+of+the+Galaxy+Vol.+2", type: "Any", year: "Any")
            if let film = film {
                XCTAssertEqual(film.imdbID, "tt3896198")
            } else {
                XCTFail()
            }
        } catch let error as FSFilmFetchingError {
            XCTFail(error.rawValue)
        }
    }
    
    func testSearchForListGuardiansShouldNotThrowErrors() async throws {
        do {
            let _ = try await NetworkManager.shared.fetchListOfFilms(with: "Guardians+of+the+Galaxy+Vol.+2", type: "Any", year: "Any")
        } catch let error as FSFilmFetchingError {
            XCTFail(error.rawValue)
        }
    }
    
    func testFetchingFilmWillSucceed() async throws {
        // Arrange and Act
        let film = try await NetworkManager.shared.fetchFilm(fetchBy: .id, with: "tt3896198", type: "Any", year: "Any")
        
        // Assert
        XCTAssertEqual(film?.imdbID, FilmMock.gogv2.imdbID)
    }
    
    func testFetchingGuardiansFrom2018MovieTypeShouldReturnMoreThan1Results() async throws {
        // Arrange and Act
        let films = try await NetworkManager.shared.fetchListOfFilms(with: "Guardians", type: "Movie", year: "2018")
        
        // Assert
        XCTAssert(films.count > 1)
    }
    
    // MARK: - Poster fetching
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
    
    // MARK: - ARResource fetching
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
