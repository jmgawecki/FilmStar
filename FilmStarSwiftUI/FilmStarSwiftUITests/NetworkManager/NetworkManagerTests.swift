import XCTest
@testable import FilmStarSwiftUI

class NetworkManagerTests: XCTestCase {
    
    func testSearchWithIDtt3896198ShouldFetchFilm() async throws {
        // Arrange
        let mockFilm = FilmMock.gogv2
        
        // Act
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        let endpoint = "https://www.omdbapi.com/?i=tt3896198&apikey=653d2e0a"
        guard let url = URL(string: endpoint)
        else {
            XCTFail("URL Format is wrong")
            return
        }
        
        let request = URLRequest.init(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else {
            XCTFail("Response was not correct")
            return
        }
        
        do {
            let film = try JSONDecoder().decode(FilmMock.self, from: data)
            expectation.fulfill()
            // Assert
            
            XCTAssertEqual(film, mockFilm)
            
        } catch let error {
            XCTFail(error.localizedDescription)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSearchWithTitleShouldFetchFilm() async throws {
        // Arrange
        let mockFilm = FilmMock.gogv2
        
        // Act
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        let endpoint = "https://www.omdbapi.com/?t=Guardians+of+the+Galaxy+Vol.+2&apikey=653d2e0a"
        guard let url = URL(string: endpoint)
        else {
            XCTFail("URL Format is wrong")
            return
        }
        
        let request = URLRequest.init(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else {
            XCTFail("Response was not correct")
            return
        }
        
        do {
            let film = try JSONDecoder().decode(FilmMock.self, from: data)
            expectation.fulfill()
            // Assert
            XCTAssertEqual(film, mockFilm)
            
        } catch let error {
            XCTFail(error.localizedDescription)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSearchWhenNoSpacesReplacedOrRemovedShouldFailWithWrongUrl() async throws {
        // Act
        let endpoint = "https://www.omdbapi.com/?t=Guardians of the Galaxy Vol.+2&apikey=653d2e0a"
        guard let _ = URL(string: endpoint)
        else {
            // Assert
            XCTAssert(true)
            return
        }
        XCTFail()
    }
    
    func testSearchWhenNoAccessIsGivenShouldThrowResponseError() async throws {
        // Act
        let endpoint = "https://www.omdbapi.com/?t=Guardians+of+the+Galaxy+Vol.+2"
        guard let url = URL(string: endpoint)
        else {
            XCTFail("URL Format is wrong")
            return
        }
        
        let request = URLRequest.init(url: url)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else {
            // Assert
            XCTAssert(true)
            return
        }
        XCTFail()
    }
    
    func testSearchByIMDbIDReturnsCorrectUrl() {
        // Arrange
        let fetchType = FilmFetchType.id
        let urlByID = URL.init(string: "https://www.omdbapi.com/?i=tt3896198&apikey=653d2e0a")
        let apiKey = "&apikey=653d2e0a"
        let movieID = "tt3896198"
        let baseURL = "https://www.omdbapi.com/?"
        // Act
        if fetchType == FilmFetchType.id {
            let url = URL.init(string: baseURL + fetchType.rawValue + movieID + apiKey)
            // Assert
            XCTAssertEqual(url, urlByID)
        } else {
            XCTFail("Wrong fetch type")
        }
    }
    
    func testSearchByTitleReturnsCorrectUrl() {
        // Arrange
        let fetchType = FilmFetchType.title
        let urlByID = URL.init(string: "https://www.omdbapi.com/?t=Guardians+of+the+Galaxy+Vol.+2&apikey=653d2e0a")
        let apiKey = "&apikey=653d2e0a"
        let movieTitle = "Guardians of the Galaxy Vol. 2"
        let baseURL = "https://www.omdbapi.com/?"
        // Act
        if fetchType == FilmFetchType.title {
            let formattedTitle = movieTitle.replacingOccurrences(of: " ", with: "+")
            let url = URL.init(string: baseURL + fetchType.rawValue + formattedTitle + apiKey)
            // Assert
            XCTAssertEqual(url, urlByID)
        } else {
            XCTFail("Wrong fetch type")
        }
    }
    
    // MARK: - NetworkManager Real
    
    func testFetchingtt3896198WithfetchFilmMethodSucceeds() async throws {
        do {
            let film = try await NetworkManager.shared.fetchFilm(fetchBy: .id, with: "tt3896198")
            XCTAssertEqual(film.imdbID, "tt3896198")
        } catch let error as FSError {
            XCTFail(error.rawValue)
        }
    }
    
    func testFetchingGuardiansWithTitleWithfetchFilmMethodSucceeds() async throws {
        do {
            let film = try await NetworkManager.shared.fetchFilm(fetchBy: .title, with: "Guardians+of+the+Galaxy+Vol.+2")
            XCTAssertEqual(film.imdbID, "tt3896198")
        } catch let error as FSError {
            XCTFail(error.rawValue)
        }
    }
}



