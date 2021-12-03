import XCTest

class SearchScreenTests: XCTestCase {
    // MARK: - IMDbID Recognition
    func testRecognisedIMDbID() {
        // Arrange
        let movieID = "tt3896198"
        
        // Act
        if movieID.count == 9,
           (String(movieID.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            // Assert
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testIMDbIDPrefixTooShortWillFail() {
        // Arrange
        let movieID = "t3896198"
        
        // Act
        if movieID.count == 9,
           (String(movieID.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            XCTAssert(false)
        } else {
            // Assert
            XCTAssert(true)
        }
    }
    
    func testIMDbIDPrefixTooLongWillFail() {
        // Arrange
        let movieID = "ttt3896198"
        
        // Act
        if movieID.count == 9,
           (String(movieID.dropLast(7)).filter({ $0.isLetter })).count == 2,
           ((movieID.dropFirst(2)) as NSString).integerValue != 0 {
            XCTAssert(false)
        } else {
            // Assert
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
            XCTAssert(false)
        } else {
            // Assert
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
            XCTAssert(false)
        } else {
            // Assert
            XCTAssert(true)
        }
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
