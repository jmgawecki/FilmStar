import XCTest
@testable import FilmStarSwiftUI

class SearchScreenTests: XCTestCase {
    // MARK: - IMDbID Recognition
    func test10CharsIMDbIDRecognitionWillSucceed() {
        // Arrange
        let movieID = "tt38961982"
        
        // Act
        if movieID.count == 9,
           (String(movieID.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            // Assert
            XCTAssert(false, "Provided IMDbID had 2 chars and 8 digits, not 7")
        } else if movieID.count == 10,
                  (String(movieID.dropLast(8)).filter({ $0.isLetter })).count == 2,
                  ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func test9CharsIMDbIDRecognitionWillSucceed() {
        // Arrange
        let movieID = "tt3896198"
        
        // Act
        if movieID.count == 9,
           (String(movieID.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            // Assert
            XCTAssert(true)
        } else if movieID.count == 10,
                  (String(movieID.dropLast(8)).filter({ $0.isLetter })).count == 2,
                  ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            XCTAssert(false, "Provided IMDbID had 2 chars and 7 digits, not 8")
        } else {
            XCTAssert(false)
        }
    }
    
    func test9LongIMDbIDButTooManyCharsWillFail() {
        // Arrange
        let movieID = "ttt3896198"
        
        // Act
        if movieID.count == 9,
           (String(movieID.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            // Assert
            XCTAssert(false)
        } else if movieID.count == 10,
                  (String(movieID.dropLast(8)).filter({ $0.isLetter })).count == 2,
                  ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            print(((movieID.dropFirst(2)) as NSString).integerValue != 0)
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
    func testIMDbIDPrefixTooShortWillFail() {
        // Arrange
        let movieID = "t3896198"
        
        // Act
        if movieID.count == 9,
           (String(movieID.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            // Assert
            XCTAssert(false)
        } else if movieID.count == 10,
                  (String(movieID.dropLast(8)).filter({ $0.isLetter })).count == 2,
                  ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
    func testIMDbIDSuffixTooShortWillFail() {
        // Arrange
        let movieID = "tt896198"
        
        // Act
        if movieID.count == 9,
           (String(movieID.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            // Assert
            XCTAssert(false)
        } else if movieID.count == 10,
                  (String(movieID.dropLast(8)).filter({ $0.isLetter })).count == 2,
                  ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
    func testIMDbIDSuffixTooLongWillFail() {
        // Arrange
        let movieID = "tt333896198"
        
        // Act
        if movieID.count == 9,
           (String(movieID.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            // Assert
            XCTAssert(false)
        } else if movieID.count == 10,
                  (String(movieID.dropLast(8)).filter({ $0.isLetter })).count == 2,
                  ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            XCTAssert(false)
        } else {
            XCTAssert(true)
        }
    }
    
    func testMethodPrepareForFilmFetchingShouldReturnIdTypeAndIdStringFor8ID() {
        // Arrange
        let sut = FSViewModel()
        let id = "tt3896198"
        let expected = (FilmFetchType.id, "tt3896198")
        
        // Act
        let result = sut.prepareForFilmFetching(with: id)
        
        // Assert
        
        XCTAssertEqual(result.0, expected.0)
    }
    
    func testMethodPrepareForFilmFetchingShouldReturnIdTypeAndIdStringFor8ID2() {
        // Arrange
        let sut = FSViewModel()
        let id = "tt3896198"
        let expected = (FilmFetchType.id, "tt3896198")
        
        // Act
        let result = sut.prepareForFilmFetching(with: id)
        
        // Assert
        
        XCTAssertEqual(result.1, expected.1)
        
    }
    
    func testMethodPrepareForFilmFetchingShouldReturnIdTypeAndIdStringFor9ID() {
        // Arrange
        let sut = FSViewModel()
        let id = "tt38961938"
        let expected = (FilmFetchType.id, "tt38961938")
        
        // Act
        let result = sut.prepareForFilmFetching(with: id)
        
        // Assert
        
        XCTAssertEqual(result.0, expected.0)
    }
    
    func testMethodPrepareForFilmFetchingShouldReturnIdTypeAndIdStringFor9ID2() {
        // Arrange
        let sut = FSViewModel()
        let id = "tt38961938"
        let expected = (FilmFetchType.id, "tt38961938")
        
        // Act
        let result = sut.prepareForFilmFetching(with: id)
        
        // Assert
        
        XCTAssertEqual(result.1, expected.1)
    }
    
    func testCapitalIDShouldReturnLowercased() {
        // Arrange
        let sut = FSViewModel()
        let id = "TT38961938"
        let expected = (FilmFetchType.id, "tt38961938")
        
        // Act
        let result = sut.prepareForFilmFetching(with: id)
        
        // Assert
        print(result.1)
        XCTAssertEqual(result.1, expected.1)
    }
    
    func testMethodPrepareForFilmFetchingShouldReturnTitleTypeAndTitleStringFor9Title() {
        // Arrange
        let sut = FSViewModel()
        let title = "Guardians of the Galaxy vol. 2"
        let expected = (FilmFetchType.title, "Guardians+of+the+Galaxy+vol.+2")
        
        // Act
        let result = sut.prepareForFilmFetching(with: title)
        
        // Assert
        
        XCTAssertEqual(result.0, expected.0)
    }
    
    func testMethodPrepareForFilmFetchingShouldReturnTitleTypeAndTitleStringFor9Title2() {
        // Arrange
        let sut = FSViewModel()
        let title = "Guardians of the Galaxy vol. 2"
        let expected = (FilmFetchType.title, "Guardians+of+the+Galaxy+vol.+2")
        
        // Act
        let result = sut.prepareForFilmFetching(with: title)
        
        // Assert
        
        XCTAssertEqual(result.1, expected.1)
    }
    
    // MARK: - Title mutation
    
    func testSpacesFromTitleReplacedWithPlusSigns() {
        // Arrange
        let sut = "Guardians of the Galaxy Vol. 2"
        let result = "Guardians+of+the+Galaxy+Vol.+2"
        
        // Act
        let mutatedTitle = sut.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        
        // Assert
        XCTAssertEqual(mutatedTitle, result)
    }
    
    func testSpacesFromTitleReplacedWithPlusSignsAndExtraLinesRemoved() {
        // Arrange
        let sut = "\n\n\n\nGuardians of the Galaxy Vol. 2"
        let result = "Guardians+of+the+Galaxy+Vol.+2"
        
        // Act
        let mutatedTitle = sut.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        
        // Assert
        XCTAssertEqual(mutatedTitle, result)
    }
    
    func testSpacesFromTitleReplacedWithAndExtraSpacesFromFronAndEndRemoved() {
        // Arrange
        let sut = "      Guardians of the Galaxy Vol. 2        "
        let result = "Guardians+of+the+Galaxy+Vol.+2"
        
        // Act
        let mutatedTitle = sut.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        
        // Assert
        XCTAssertEqual(mutatedTitle, result)
    }
    
    func testMutatingTitleWithDoubleSpaceTypoWillFail() {
        // Arrange
        let sut = "Guardians of the  Galaxy Vol. 2"
        let result = "Guardians+of+the+Galaxy+Vol.+2"
        
        // Act
        let mutatedTitle = sut.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        
        // Assert
        XCTAssertNotEqual(mutatedTitle, result)
    }
}
