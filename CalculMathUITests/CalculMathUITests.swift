import XCTest
import Foundation

class CalculusUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        // Terminate the simulator process using simctl
        let task = URLSession.shared.dataTask(with: URL(string: "file:///usr/bin/xcrun?simctl%20shutdown%20booted")!) { (_, _, error) in
            if let error = error {
                print("Error shutting down simulator: \(error)")
            }
        }
        task.resume()
    }
    
    func testButtonTapAndDisplay() {
        let app = XCUIApplication()
        
        // Tap the "1" button (finds the button with the label "1" and simulates a tap on it. You'll need to make sure the accessibility labels of your buttons match the text they display.)
        app.buttons["1"].tap()
        
        // Tap the "2" button
        app.buttons["2"].tap()
        
        // Get the display text (app.staticTexts.element(matching: .any, identifier: "displayValue").label: accesses the text displayed on the screen)
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        
        // Assert that the display shows "12"
        XCTAssertEqual(displayText, "12", "Display value is incorrect")
    }
    
    func testAdditionUI() {
        let app = XCUIApplication()
        
        // Tap "2"
        app.buttons["2"].tap()
        // Tap "+"
        app.buttons["+"].tap()
        // Tap "3"
        app.buttons["3"].tap()
        // Tap "="
        app.buttons["="].tap()
        
        // Get the display text
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        
        // Assert that the display shows "5"
        XCTAssertEqual(displayText, "5", "Addition UI test failed")
    }
}


//import XCTest
//import Foundation

//class CalculMathUITests: XCTestCase {

//    override func setUpWithError() throws {
//        try super.setUpWithError()
//        continueAfterFailure = false // Stop running tests if one fails (This setting stops the test execution immediately if an assertion fails.)
        
        // XCUIApplication(): This class represents your app and allows you to interact with its UI elements.
//        XCUIApplication().launch() // Launch the app (app.launch(): This launches your app before the test begins)
//    }

    /* clones alive after tests done
    override func tearDownWithError() throws {
        XCUIApplication().terminate()
        try super.tearDownWithError()
    }
     */
    
//    override func tearDownWithError() throws {
        // Terminate the simulator process
//        let task = Process()
//        task.launchPath = "/usr/bin/xcrun"
//        task.arguments = ["simctl", "shutdown", "booted"]
//        task.launch()
//        task.waitUntilExit()
//    }
    
    



