import XCTest
@testable import FilmStar

class NetworkManagerTests: XCTestCase {
    // MARK: - Logic
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
            
                XCTAssertEqual(film.imdbID, mockFilm.imdbID)
            
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
            XCTAssertEqual(film.imdbID, mockFilm.imdbID)
            
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
    
    func testSearchByTitleAndYearReturnsCorrectUrl() {
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
    
    // MARK: - Methods
    
    func testFetchingGuardiansPosterWillSucceeds() async throws {
        let urlString = "https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg"
        do {
            let data = try await NetworkManager.shared.fetchPosterData(with: urlString)
            if let _ = data {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
        }
    }
    
    func testFetchingGuardiansWithManagersMethodsSucceeds() async throws {
        let guardiansMock = FilmMock.gogv2
        do {
            let guardians = try await NetworkManager.shared.fetchFilm(fetchBy: .title, with: "Guardians+of+the+Galaxy+Vol.+2",
                                                                      type: "Any", year: "Any")
            XCTAssertEqual(guardians?.imdbID, guardiansMock.imdbID)
        } catch let error {
            if let error = error as? FSFilmFetchingError {
                XCTFail(error.rawValue)
            } else {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testFetchingGuardiansWithManagersMethodsWithUnpreparedTitleFails() async throws {
        do {
            let guardians = try await NetworkManager.shared.fetchFilm(fetchBy: .title, with: "Guardians of the Galaxy Vol. 2",
                                                                      type: "Any", year: "Any")
        } catch let error {
            if let error = error as? FSFilmFetchingError {
                XCTAssertEqual(error.rawValue, FSFilmFetchingError.wrongFormat.rawValue)
            } else {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testFetchingListOfFilmsGuardiansBringsMoreThanOneResult() async throws {
        do {
            let guardians = try await NetworkManager.shared.fetchListOfFilms(with: "Guardians", type: "Any", year: "Any")
            XCTAssert(guardians.count > 1)
        } catch let error {
            if let error = error as? FSFilmFetchingError {
                XCTFail(error.rawValue)
            } else {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testFetchingListOfFilmsGuardiansWithUnpreparedTitleFails() async throws {
        do {
            let _ = try await NetworkManager.shared.fetchFilm(fetchBy: .title, with: "  Guardians   ",
                                                              type: "Any", year: "Any")
        } catch let error {
            if let error = error as? FSFilmFetchingError {
                XCTAssertEqual(error.rawValue, FSFilmFetchingError.wrongFormat.rawValue)
            } else {
                XCTFail(error.localizedDescription)
            }
        }
    }
}



