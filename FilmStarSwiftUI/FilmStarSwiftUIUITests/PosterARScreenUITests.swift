import XCTest
import ARKit

class PosterARScreenUITests: XCTestCase {
    static let isARExperienceAvailable = ARWorldTrackingConfiguration.supportsFrameSemantics([.personSegmentationWithDepth, .sceneDepth]) && ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification)
    
    func testTappingARPosterButtonInFilmDetailsScreenTakesToPosterARScreen() throws {
        if PosterARScreenUITests.isARExperienceAvailable {
            let app = XCUIApplication()
            app.launch()
            
            let searchTextField = app.textFields["Search for film.."]
            searchTextField.tap()
            searchTextField.typeText("IT")
            
            let searchOneButton = app.buttons["Search one"]
            searchOneButton.tap()
            
            let arPosterButton = app.buttons["arPosterButton"]
            let _ = arPosterButton.waitForExistence(timeout: 3)
            
            arPosterButton.tap()
            
            sleep(30)
        }
    }
}
