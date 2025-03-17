import XCTest
import Foundation

class CalculusUITests: XCTestCase {

    let currentEnvironment = "development"
//    let currentEnvironment = "debugging"
//    let currentEnvironment = "staging"
//    let currentEnvironment = "production"

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false

        if currentEnvironment == "development" {
            if self.name.contains("Factorial") {
                throw XCTSkip("Skipping factorial tests for development environment.")
            }
        }

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
    
    func testAdditionUI_1stPositiveInt2ndPositiveInt() {
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
    
    func testAdditionUI_1stPositiveDouble2ndPositiveDouble() {
        let app = XCUIApplication()
        
        // 1st: "2.4"
        // Tap "2"
        app.buttons["2"].tap()
        // Tap "."
        app.buttons["."].tap()
        // Tap "4"
        app.buttons["4"].tap()
        
        // operation "+"
        app.buttons["+"].tap()
        
        // 2nd: "3.25"
        // Tap "3"
        app.buttons["3"].tap()
        // Tap "."
        app.buttons["."].tap()
        // Tap "2"
        app.buttons["2"].tap()
        // Tap "5"
        app.buttons["5"].tap()
        
        // calculation "="
        app.buttons["="].tap()
        
        // Get the display text
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        
        // expected: 5.65
        // assert that the display shows correct result
        XCTAssertEqual(displayText, "5.65", "Addition UI test (1st Positive Double 2nd Positive Double) failed)")
    }
    
    func testAdditionUI_1stNegativeDouble2ndPositiveDouble() {
        let app = XCUIApplication()

        // 1st: "-2.4"
        // Tap "-"
        app.buttons["-"].tap()
        // Tap "2"
        app.buttons["2"].tap()
        // Tap "."
        app.buttons["."].tap()
        // Tap "4"
        app.buttons["4"].tap()

        // operation "+"
        app.buttons["+"].tap()

        // 2nd: "3.25"
        // Tap "3"
        app.buttons["3"].tap()
        // Tap "."
        app.buttons["."].tap()
        // Tap "2"
        app.buttons["2"].tap()
        // Tap "5"
        app.buttons["5"].tap()

        // calculation "="
        app.buttons["="].tap()

        // Get the display text
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label

        // expected: 0.85
        // assert that the display shows correct result
        XCTAssertEqual(displayText, "0.85", "Addition UI test (1st Negative Double 2nd Positive Double) failed)")
    }
    
    func testAdditionUI_1stPositiveDouble2ndIntResultPositiveeDouble() {
     let app = XCUIApplication()
        
        // 1st: "2.4"
        // Tap "2"
        app.buttons["2"].tap()
        // Tap "."
        app.buttons["."].tap()
        // Tap "4"
        app.buttons["4"].tap()
        
        // operation "+"
        app.buttons["+"].tap()
        
        // 2nd: "3"
        // Tap "3"
        app.buttons["3"].tap()

        // calculation "="
        app.buttons["="].tap()
        
        // Get the display text
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        
        // expected: 5.4
        // assert that the display shows correct result
        XCTAssertEqual(displayText, "5.4", "Addition UI test (1st Positive Double 2nd Positive Int) failed)")
    }
    
    func testSquareRootUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["9"].firstMatch.tap()
        
        app.buttons["√"].firstMatch.tap()
        // Get the display text
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        
        // expected: 3
        // assert that the display shows correct result
        XCTAssertEqual(displayText, "3", "Square Root UI test (Arg: Positive Int, Result: Positive Int) failed")
    }
    
    func testSquareRootUI_NegativeIntResultError() {
        let app = XCUIApplication()
        
        app.buttons["-"].firstMatch.tap()
        app.buttons["9"].firstMatch.tap()
        
        app.buttons["√"].firstMatch.tap()
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        
        XCTAssertEqual(displayText, "Error", "Square Root UI test (Arg: Negative Int, Result: Error) failed")
    }
    
    func testSquareRootUI_PositiveDoubleResultPositiveDouble() {
        let app = XCUIApplication()
        
        app.buttons["6"].firstMatch.tap()
        app.buttons["."].firstMatch.tap()
        app.buttons["7"].firstMatch.tap()
        app.buttons["6"].firstMatch.tap()

        app.buttons["√"].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        
        XCTAssertEqual(displayText, "2.6", "Square Root UI test (Arg: Double, Result: Positive Double) failed")
    }
    
    func testSquareUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["4"].firstMatch.tap()
        app.buttons["x²"].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        
        XCTAssertEqual(displayText, "16", "Square UI test (Arg: Int, Result: Int) failed")
    }
    
    func testSquareUI_PositiveDoubleResultPositiveDouble() {
        let app = XCUIApplication()
        
        app.buttons["3"].firstMatch.tap()
        app.buttons["."].firstMatch.tap()
        app.buttons["2"].firstMatch.tap()
        app.buttons["6"].firstMatch.tap()
        app.buttons["x²"].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label

        XCTAssertEqual(displayText, "10.6276", "Square UI test (Arg: Positive Double, Result: Positive Double) failed")
    }
    
    func testPowerOfTwoAndCubeRootUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["3"].firstMatch.tap()
        app.buttons["x²"].firstMatch.tap()
        app.buttons["∛"].firstMatch.tap()

        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "2", "Power of two and cube root UI test (Arg: Int, Result: Int) failed")
    }
    
    func testCubeAndCubeRootUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["3"].firstMatch.tap()
        app.buttons["x³"].firstMatch.tap()
        app.buttons["∛"].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "3", "Cube and cube root UI test (Arg: Int, Result: Int) failed")
    }
    
    func testExponentiationUI_PositiveIntPositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["2"].firstMatch.tap()
        app.buttons["xʸ"].firstMatch.tap()
        app.buttons["3"].firstMatch.tap()
        app.buttons["="].firstMatch.tap()

        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "8", "xʸ UI test (Arg: Int, Arg: Int, Result: Int) failed")
    }

    func testExponentiationUI_PositiveIntNegativeIntResultNegativeInt() {
        let app = XCUIApplication()
        
        app.buttons["2"].firstMatch.tap()
        app.buttons["xʸ"].firstMatch.tap()
        app.buttons["-3"].firstMatch.tap()
        app.buttons["="].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "0.125", "xʸ UI test (Arg: Int, Arg: Int, Result: Int) failed")
    }
    
    func testExponentiationUI_NegativeIntPositiveIntResultNegativeInt() {
        let app = XCUIApplication()
        
        app.buttons["-2"].firstMatch.tap()
        app.buttons["xʸ"].firstMatch.tap()
        app.buttons["3"].firstMatch.tap()
        app.buttons["="].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "-8", "xʸ UI test (Arg: Int, Arg: Int, Result: Int) failed")
    }
     
    func testSquareAndFactorialUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        app.launch()

        if currentEnvironment == "development" {
            XCTSkip("Skipping factorial tests for development environment.")
        }
        app.buttons["3"].firstMatch.tap()
        app.buttons["x²"].firstMatch.tap()
        app.buttons["x!"].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "362880", "x²x! UI test (Arg: Int, Result: Int) failed")
    }
    
    func testCubeAndFactorialUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        app.launch()

        if currentEnvironment == "development" {
            XCTSkip("Skipping factorial tests for development environment.")
        }
        
        app.buttons["2"].firstMatch.tap()
        app.buttons["x³"].firstMatch.tap()
        app.buttons["x!"].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "40320", "x³x! UI test (Arg: Int, Result: Int) failed")
    }

    
    func testPowerOf10UI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["2"].firstMatch.tap()
        app.buttons["10ˣ"].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "100", "10ˣ UI test (Arg: Int, Result: Int) failed")
    }
    
    func testPowerOf10UI_NegativeIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["-"].firstMatch.tap()
        app.buttons["2"].firstMatch.tap()
        app.buttons["10ˣ"].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "0.01", "10ˣ UI test (Arg: Negative Int, Result: Positive Double) failed")
    }
    
    func testSquareRootPowerOf10UI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["9"].firstMatch.tap()
        app.buttons["√"].firstMatch.tap()
        app.buttons["10ˣ"].firstMatch.tap()
        
        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "1,000", "√ and 10ˣ UI test (Arg: positive Int, Result: Positive Int) failed")
    }
    
    func testSquareRootTwiceUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["2"].firstMatch.tap()
        app.buttons["5"].firstMatch.tap()
        app.buttons["6"].firstMatch.tap()

        app.buttons["√"].firstMatch.tap()
        app.buttons["√"].firstMatch.tap()

        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "4", "√ twice UI test (Arg: positive Int, Result: Positive Int) failed")
    }
    
    func testSquareRootTripleUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        // 65536
        app.buttons["6"].firstMatch.tap()
        app.buttons["5"].firstMatch.tap()
        app.buttons["5"].firstMatch.tap()
        app.buttons["3"].firstMatch.tap()
        app.buttons["6"].firstMatch.tap()

        app.buttons["√"].firstMatch.tap()
        app.buttons["√"].firstMatch.tap()
        app.buttons["√"].firstMatch.tap()

        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "4", "√ triple UI test (Arg: positive Int, Result: Positive Int) failed")
    }
    
    func testCubeRootTwiceUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        // 19683
        app.buttons["1"].firstMatch.tap()
        app.buttons["9"].firstMatch.tap()
        app.buttons["6"].firstMatch.tap()
        app.buttons["8"].firstMatch.tap()
        app.buttons["3"].firstMatch.tap()

        app.buttons["∛"].firstMatch.tap()
        app.buttons["∛"].firstMatch.tap()

        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "3", "∛ twice UI test (Arg: positive Int, Result: Positive Int) failed")
    }
    
    func testPowerOf10AndCubeRootUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["3"].firstMatch.tap()
        app.buttons["10ˣ"].firstMatch.tap()
        app.buttons["∛"].firstMatch.tap()

        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "10", "10ˣ and ∛ UI test (Arg: positive Int, Result: Positive Int) failed")
    }
    
    func testPSquareAndCubeUI_PositiveIntResultPositiveInt() {
        let app = XCUIApplication()
        
        app.buttons["3"].firstMatch.tap()
        app.buttons["x²"].firstMatch.tap()
        app.buttons["x³"].firstMatch.tap()

        let displayText = app.staticTexts.element(matching: .any, identifier: "displayValue").label
        XCTAssertEqual(displayText, "729", "x² and x³ UI test (Arg: positive Int, Result: Positive Int) failed")
    }
    
}
