import XCTest

class FilmDetailsScreenUITests: XCTestCase {
    func testSearchingForITFilmTakesToFilmDetailsScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["Search for film.."]
        searchTextField.tap()
        searchTextField.typeText("IT")
        
        let searchOneButton = app.buttons["Search one"]
        searchOneButton.tap()
        
        let filmDetailsScrollView = app.scrollViews["filmDetailsScreenScrollView"]
        XCTAssert(filmDetailsScrollView.waitForExistence(timeout: 5))
        
    }
    
    func testSearchingForListOfGuardiansThenTappingCellTakesToFilmDetailsScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["Search for film.."]
        searchTextField.tap()
        searchTextField.typeText("Guardians")
        
        let searchOneButton = app.buttons["Search many"]
        searchOneButton.tap()
        
        let tableCell = app.tables.children(matching: .cell).element(boundBy: 0)
        tableCell.tap()
        
        let filmDetailsScrollView = app.scrollViews["filmDetailsScreenScrollView"]
        XCTAssert(filmDetailsScrollView.waitForExistence(timeout: 5))
    }
}
