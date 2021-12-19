import XCTest

class FavouritesScreenUITests: XCTestCase {
    // MARK: - FavouritesScreen
    
    func testFavouritesScreenExists() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars.element
        
        XCTAssert(tabBar.exists)
    }
    
    func testClickingSecondTabBarButtonTakesToFavouritesFilmsScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let favouritesTabButton = app.tabBars.buttons.element(boundBy: 1)
        
        favouritesTabButton.tap()
        
        let animatingFavouritesImage = app.images["animatingFavouritesImage"]
        let favouritesFilmHeader = app.staticTexts["favouritesFilmHeader"]
        
        if !favouritesFilmHeader.exists {
            XCTAssert(animatingFavouritesImage.exists)
        } else if !animatingFavouritesImage.exists {
            XCTAssert(favouritesFilmHeader.exists)
        } else {
            XCTFail()
        }
    }
    
    func testSavingAFilmToFavouriteSearchedOneAndDeletingAllTheFavouritesWillDisplayAnimatingImageInFavourites() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["Search for film.."]
        searchTextField.tap()
        searchTextField.typeText("IT")
        
        let searchOneButton = app.buttons["Search one"]
        searchOneButton.tap()
        
        let saveFilmButton = app.buttons["saveFilmButton"]
        let backButton = app.buttons["backButton"]
        
        if backButton.waitForExistence(timeout: 5) {
            if saveFilmButton.waitForExistence(timeout: 5) {
                saveFilmButton.tap()
            }
            backButton.tap()
        }
        
        let keyboard = app.keyboards.element(boundBy: 0)
        keyboard.buttons["return"].tap()
        
        let favouritesTabButton = app.tabBars.buttons.element(boundBy: 1)
        
        favouritesTabButton.tap()
        
        let cells = app.tables.element(boundBy: 0).children(matching: .cell).allElementsBoundByIndex
        
        for _ in 0 ..< cells.count {
            cells[0].swipeLeft()
            cells[0].buttons["Delete"].tap()
        }
        
        let animatingFavouritesImage = app.images["animatingFavouritesImage"]
        
        XCTAssert(animatingFavouritesImage.waitForExistence(timeout: 2))
    }
}
