import XCTest
@testable import CalculMath   // makes app's internal code accessible to the test target

class calculMathTests: XCTestCase {
    var calculMath: CalculMath!
    
    // setUpWithError & tearDownWithError: to set up and clean up any resources needed for the tests. In this case, we create a new Calculator instance before each test and set it to nil after each test.
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        calculMath = CalculMath()
    }
    
    override func tearDownWithError() throws {
        calculMath = nil
        try super.tearDownWithError()
    }
    
    func testAddition_PositiveNumbers() {
        let result = calculMath.add(5, 3)
        XCTAssertEqual(result, 8, "Addition of positive numbers failed")
    }
    
    func testAddition_NegativeNumbers() {
        let result = calculMath.add(-5, -3)
        XCTAssertEqual(result, -8, "Addition of negative numbers failed")
    }
    
    func testAddition_PositiveAndNegativeNumbers() {
        let result = calculMath.add(5, -3)
        XCTAssertEqual(result, 2, "Addition of positive and negative numbers failed")
    }
    
    func testAddition_1stPositiveIntNumber2ndPositiveDoubleNumber() {
        let result = calculMath.add(5, 3.4)
        XCTAssertEqual(result, 8.4, "Addition of 1st Positive Int Number & 2nd Positive Double Number failed")
    }
    
    func testAddition_1stNegativeDoubleNum2ndPositiveIntNumPositiveResult() {
        let result = calculMath.add(-5.4, 8)
        XCTAssertEqual(result, 2.6, accuracy: 0.0001, "Addition of 1st Negative Double Num & 2nd Positive Int Num with Positive Result failed")
    }
    
    func testAddition_1stPositiveeDoubleNum2ndPositiveIntNumPositiveResult() {
        
    }
    
    
    func testAddition_Zero() {
        let result = calculMath.add(5, 0)
        XCTAssertEqual(result, 5, "Addition with zero failed")
    }
    
    func testAddition_TwoZeros() {
        let result = calculMath.add(0, 0)
        XCTAssertEqual(result, 0, "Addition with two zeros failed")
    }
    
    func testDivision() {
        let result = calculMath.divide(10, 2)
        XCTAssertEqual(result, 5, "Divide test failed")
        
        // Since your divide() function returns Double.nan when dividing by zero, we use XCTAssertTrue and isNaN to check if the result is "Not a Number."
        let divisionByZeroResult = calculMath.divide(10, 0)
        XCTAssertTrue(divisionByZeroResult.isNaN, "Divide by zero test is failed")
    }
}
