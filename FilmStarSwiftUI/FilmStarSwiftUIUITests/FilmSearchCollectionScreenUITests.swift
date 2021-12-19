import XCTest

class FilmSearchCollectionScreenUITests: XCTestCase {
    func testSearchingForGuardiansFilmTakesToFilmsSearchCollectionScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["Search for film.."]
        searchTextField.tap()
        searchTextField.typeText("Guardians")
        
        let searchOneButton = app.buttons["Search many"]
        searchOneButton.tap()
        
        let filmsList = app.tables["filmsList"]
        XCTAssert(filmsList.exists)
    }
    
    func testSearchingForITFilmTakesToFilmsSearchCollectionScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["Search for film.."]
        searchTextField.tap()
        searchTextField.typeText("Guardians")
        
        let searchOneButton = app.buttons["Search many"]
        searchOneButton.tap()
        
        let filmsCount = app.tables.children(matching: .cell).count
        XCTAssertEqual(filmsCount, 10)
    }
    
    func testAfterSearchingForITFilmTappingGoBackButtonTakesToSearchScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["Search for film.."]
        searchTextField.tap()
        searchTextField.typeText("Guardians")

        let searchOneButton = app.buttons["Search many"]
        searchOneButton.tap()

        let goBackButton = app.buttons["goBackButton"]
        goBackButton.tap()
        
        let filmsList = app.tables["filmsList"]
        XCTAssertFalse(filmsList.exists)
    }
}
