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
    
    func testAddition_1stPositiveeIntNum2ndPositiveDoubleNumPositiveResult() {
        let result = calculMath.add(8, 5.4)
        XCTAssertEqual(result, 13.4, accuracy: 0.0001, "Addition of 1st Positive Int Num & 2nd Positive Double Num with Positive Result failed")
    }
    
    func testAddition_1stZero2ndPositiveDoubleNumPositiveResult() {
        let result = calculMath.add(0, 5.4)
        XCTAssertEqual(result, 5.4, "Addition of 1st 0 num & 2nd Positive Double Num with Positive Result failed")
    }
    
    func testAddition_TwoZeros() {
        let result = calculMath.add(0, 0)
        XCTAssertEqual(result, 0, "Addition with two zeros failed")
    }
    
    func testDivision_1stPositiveInt2ndPositiveInt() {
        let result = calculMath.divide(10, 2)
        XCTAssertEqual(result, 5, "Divide test failed")
        
        // Since your divide() function returns Double.nan when dividing by zero, we use XCTAssertTrue and isNaN to check if the result is "Not a Number."
        let divisionByZeroResult = calculMath.divide(10, 0)
        XCTAssertTrue(divisionByZeroResult.isNaN, "Divide by zero test is failed")
    }
    
    func testDivision_1stNegativeInt2ndPositiveInt() {
        let result = calculMath.divide(-10, 2)
        XCTAssertEqual(result, -5, "Division test 1st Negative Int 2nd Positive Int failed")
    }
    
    func testDivisionByZero() {
        let result = calculMath.divide(10, 0)
        XCTAssertTrue(result.isNaN, "Division by zero should return NaN")
    }
    
    func testMultipl_1stPositiveInt2ndNegativeInt() {
        let result = calculMath.multiply(10, -2)
        XCTAssertEqual(result, -20, "Multipl 1st Positive Int 2nd Negative Int failed")
    }
    
    func testMultipl_1stPositiveDouble2ndNegativeDouble() {
        let result = calculMath.multiply(1.75, -2.2)
        XCTAssertEqual(result, -3.85, accuracy: 0.0001, "Multipl 1st Positive Double 2nd Negative Double failed")
    }
    
    func testMultipl_1stNegativeInt2ndZero() {
        let result = calculMath.multiply(-10, 0)
        XCTAssertEqual(result, 0, "Multipl 1st Negative Int 2nd Zero faile")
    }
    
    func testSubtract_1stInt2ndIntResultNegative() {
        let result = calculMath.subtract(2, 10)
        XCTAssertEqual(result, -8,  "Subtract 1st Positive Int 2nd Negative Int failed")
    }
    
    func testSubtract_1stDouble2ndDoubleResultPositive() {
        let result = calculMath.subtract(10.5, 2.2)
        XCTAssertEqual(result, 8.3, accuracy: 0.0001, "Subtract 1st Positive Double 2nd Negative Double failed")
    }
    
    func testSubtract_1stNegativeInt2ndZeroResultNegative() {
        let result = calculMath.subtract(-10, 0)
        XCTAssertEqual(result, -10, "Subtract 1st Negative Int 2nd Zero failed")
    }
    
    func testDivide_1stPositiveInt2ndPositiveIntResultPositive() {
        let result = calculMath.divide(10, 2)
        XCTAssertEqual(result, 5, "Divide 1st Positive Int 2nd Positive Int failed")
    }
    
    func testSubtract_1stNegativeInt2ndDoubleResultNegative() {
        let result = calculMath.subtract(-10, 2.2)
        XCTAssertEqual(result, -12.2, accuracy: 0.0001, "Subtract 1st Negative Int 2nd Negative Double failed")
    }
    
    func testSquareRoot_PositiveInt() {
        do {
            let result = try calculMath.squareRoot(16)
            XCTAssertEqual(result, 4.0, accuracy: 0.0001, "Square Root Positive Int failed")
        } catch {
            XCTFail("Square root threw an unexpected error: \(error)")
        }
    }
    
    func testSquareRoot_NegativeInt() {
        do {
            let _ = try calculMath.squareRoot(-16) // We don't need the result, just that an error is thrown
            XCTFail("Square Root Negative Int failed - No error thrown") // If no error is thrown, the test should fail.
        } catch CalculMathError.invalidRoot {
            // This is the expected error, so the test passes.
        } catch {
            XCTFail("Square Root Negative Int failed - Unexpected error thrown: \(error)") // Any other error is a failure.
        }
    }
    
    
    func testCubeRoot_PositiveInt() {
        do {
            let result = try calculMath.cubeRoot(8)
            XCTAssertEqual(result, 2.0, accuracy: 0.0001, "Cube Root Positive Int failed")
        } catch {
            XCTFail("Cube root threw an unexpected error: \(error)")
        }
    }
    
    func testCubeRoot_NegativeInt() {
        do {
            let _ = try calculMath.cubeRoot(-8) // We don't need the result, just that an error is thrown
            XCTFail("Cube Root Negative Int failed - No error thrown") // If no error is thrown, the test should fail.
        } catch CalculMathError.invalidInput {
            // This is the expected error, so the test passes.
        } catch {
            XCTFail("Cube Root Negative Int failed - Unexpected error thrown: \(error)") // Any other error is a failure.
        }
    }
    
    func testPowerOfTwo_PositiveInt() {
        let result = calculMath.powerOfTwo(4)
        XCTAssertEqual(result, 16, "Power Of Two Positive Int failed")
    }
    
    func testPowerOfTwo_NegativeInt() {
        let result = calculMath.powerOfTwo(-4)
        XCTAssertEqual(result, 0.0625, "Power Of Two Negative Int failed")
    }
    
    func testPowerOfTwo_Zero() {
        let result = calculMath.powerOfTwo(0)
        XCTAssertEqual(result, 1, "Power Of Two Zero failed")
    }
    
    func testPowerOfTwo_PositiveDouble() {
        let result = calculMath.powerOfTwo(5.5)
        XCTAssertEqual(result, 45.254834, accuracy: 0.000001, "Power Of Two Positive Double failed")
    }
    
    func testPowerOfTwo_NegativeDouble() {
        let result = calculMath.powerOfTwo(-2.5)
        XCTAssertEqual(result, 0.1767766953, accuracy: 0.001, "Power Of Two Negative Double failed")
    }
    
    func testReciprocal_PositiveDouble() {
        do {
            let result = try calculMath.reciprocal(2.5)
            XCTAssertEqual(result, 0.4, accuracy: 0.001, "Reciprocal Positive Double failed")
        } catch {
            XCTFail("Reciprocal Positive Double failed")
        }        
    }
    
    func testReciprocal_Zero() {
        do {
            _ = try calculMath.reciprocal(0)
            XCTFail("Reciprocal Zero failed")
        } catch {
            XCTAssert(true)
        }
    }
    
    func testReciprocal_NegativeDouble() {
        do {
            let result = try calculMath.reciprocal(-2.5)
            XCTAssertEqual(result, -0.4, accuracy: 0.001, "Reciprocal Negative Double failed")

        } catch {
            XCTFail("Reciprocal Negative Double failed")
        }
    }
    
    func testPowerOfTen_PositiveDouble() {
        let result = calculMath.powerOfTen(2.4)
        XCTAssertEqual(result, 251.1886432, accuracy: 0.001, "Power Of Ten Positive Double failed")
    }
    
    func testPowerOfTen_Zero() {
        let result = calculMath.powerOfTen(0)
        XCTAssertEqual(result, 1, accuracy: 0.001, "Power Of Ten Zero failed")
    }
    
    func testPowerOfTen_NegativeDouble() {
        let result = calculMath.powerOfTen(-2.4)
        XCTAssertEqual(result, 0.003981071706, accuracy: 0.001, "Power Of Ten Negative Double failed")
    }
    
    func testPowerOfTen_NegativeInt() {
        let result = calculMath.powerOfTen(-2)
        XCTAssertEqual(result, 0.01, accuracy: 0.001, "Power Of Ten Negative Int failed")
    }
    
    func testPowerOfTen_PositiveInt() {
        let result = calculMath.powerOfTen(2)
        XCTAssertEqual(result, 100, "Power Of Ten Positive Int failed")
    }
    
}
