import XCTest
import ARKit
import SwiftUI
@testable import FilmStar

class SearchScreenUITests: XCTestCase {
    func testSearchManyButtonExists() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchOneButton = app.buttons["Search many"]
        
        XCTAssert(searchOneButton.exists)
    }


    func testSearchOneButtonExists() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchManyButton = app.buttons["Search one"]
        
        XCTAssert(searchManyButton.exists)
    }
    
    func testSearchTextFieldExists() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["Search for film.."]
        
        XCTAssert(searchTextField.exists)
    }
    
    func testFilterButtonExists() throws {
        let app = XCUIApplication()
        app.launch()
        
        let filterButton = app.buttons["filterButton"]
        
        XCTAssert(filterButton.exists)
    }
    
    func testTappingFilterButtonTakeToSearchFiltersScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let filterButton = app.buttons["filterButton"]
        filterButton.tap()
        
        let resetButton = app.buttons["filterResetButton"]
        let doneButton = app.buttons["filterDoneButton"]
        
        XCTAssert(resetButton.exists, "filterResetButton does not seem to appear")
        XCTAssert(doneButton.exists, "filterDoneButton does not seem to appear")
    }
    
    // MARK: - OnboardingView
//    func testOnboarding() {
////        @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
////
////        shouldShowOnboarding = true
////        defer {
////            shouldShowOnboarding = false
////        }
//
//        let app = XCUIApplication()
//        app.launchArguments = ["-shouldShowOnboarding 1"]
//        app.launch()
//
//
//
//        let pageOne = app.staticTexts["pageOne"]
//
//        XCTAssert(pageOne.exists)
//    }
}
