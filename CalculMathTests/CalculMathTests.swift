import XCTest
@testable import CalculMath

class CalculMathTests: XCTestCase {
    var calculMath: CalculMath!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        calculMath = CalculMath()
    }
    
    override func tearDownWithError() throws {
        calculMath = nil
        try super.tearDownWithError()
    }
    
    func testAddition() {
        calculMath.currentOperand = 3
        var previousResult: Double? = 5
        calculMath.currentOperator = "+"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult) // Capture the result
            calculMath.currentOperand = result // Update currentOperand
        }())
        XCTAssertEqual(calculMath.currentOperand, 8, "Addition failed")
    }
    
    func testSubtraction() {
        calculMath.currentOperand = 2
        var previousResult: Double? = 10 // Create previousResult
        calculMath.currentOperator = "-"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult) // Pass previousResult
            calculMath.currentOperand = result // Update currentOperand
        }())
        XCTAssertEqual(calculMath.currentOperand, 8, "Subtraction failed")
    }
    
    func testAddition_PositiveNumbers() {
        calculMath.currentOperand = 3
        var previousResult: Double? = 5
        calculMath.currentOperator = "+"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result // Update currentOperand
        }())
        XCTAssertEqual(calculMath.currentOperand, 8, "Addition of positive numbers failed")
    }
    
    func testAddition_NegativeNumbers() {
        calculMath.currentOperand = -3
        var previousResult: Double? = -5
        calculMath.currentOperator = "+"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result // Update currentOperand
        }())
        XCTAssertEqual(calculMath.currentOperand, -8, "Addition of negative numbers failed")
    }
    
    func testAddition_PositiveAndNegativeNumbers() {
        calculMath.currentOperand = -3
        var previousResult: Double? = 5
        calculMath.currentOperator = "+"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result // Update currentOperand
        }())
        XCTAssertEqual(calculMath.currentOperand, 2, "Addition of positive and negative numbers failed")
    }
    
    func testAddition_1stPositiveIntNumber2ndPositiveDoubleNumber() {
        calculMath.currentOperand = 3.4
        var previousResult: Double? = 5
        calculMath.currentOperator = "+"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result // Update currentOperand
        }())
        XCTAssertEqual(calculMath.currentOperand, 8.4, "Addition of 1st Positive Int Number & 2nd Positive Double Number failed")
    }
    
    func testAddition_1stNegativeDoubleNum2ndPositiveIntNumPositiveResult() {
        calculMath.currentOperand = 8
        var previousResult: Double? = -5.4
        calculMath.currentOperator = "+"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 2.6, accuracy: 0.0001, "Addition of 1st Negative Double Num & 2nd Positive Int Num with Positive Result failed")
    }
    
    func testAddition_1stPositiveeIntNum2ndPositiveDoubleNumPositiveResult() {
        calculMath.currentOperand = 5.4
        var previousResult: Double? = 8
        calculMath.currentOperator = "+"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 13.4, accuracy: 0.0001, "Addition of 1st Positive Int Num & 2nd Positive Double Num with Positive Result failed")
    }
    
    func testAddition_1stZero2ndPositiveDoubleNumPositiveResult() {
        calculMath.currentOperand = 5.4
        var previousResult: Double? = 0
        calculMath.currentOperator = "+"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 5.4, "Addition of 1st 0 num & 2nd Positive Double Num with Positive Result failed")
    }
    
    func testAddition_TwoZeros() {
        calculMath.currentOperand = 0
        var previousResult: Double? = 0
        calculMath.currentOperator = "+"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 0, "Addition with two zeros failed")
    }
    
    func testSubtractionWithNegativeNumbers() {
        calculMath.currentOperand = -3
        var previousResult: Double? = 6
        calculMath.currentOperator = "-"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 9, "Subtraction with negative numbers test failed")
    }
    
    func testDivision_1stPositiveInt2ndPositiveInt() {
        calculMath.currentOperand = 2
        var previousResult: Double? = 10
        calculMath.currentOperator = "/"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 5, "Divide test failed")
    }
    
    func testDivision_1stNegativeInt2ndPositiveInt() {
        calculMath.currentOperand = 2
        var previousResult: Double? = -10
        calculMath.currentOperator = "/"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, -5, "Division test 1st Negative Int 2nd Positive Int failed")
    }
    
    func testAddition_operandsApproach() {
        calculMath.currentOperand = 5
        var previousResult: Double? = 3
        calculMath.currentOperator = "+"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 8)
    }
    
    func testDivisionByZero() {
        calculMath.currentOperand = 0
        var previousResult: Double? = 10
        calculMath.currentOperator = "/"
        XCTAssertThrowsError(try calculMath.calculate(previousResult: &previousResult)) { error in
            XCTAssertEqual(error as? CalculMathError, CalculMathError.divisionByZero)
        }
    }
    
    func testMultipl_1stPositiveInt2ndNegativeInt() {
        calculMath.currentOperand = -2
        var previousResult: Double? = 10
        calculMath.currentOperator = "*"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, -20, "Multipl 1st Positive Int 2nd Negative Int failed")
    }
    
    func testMultipl_1stPositiveDouble2ndNegativeDouble() {
        calculMath.currentOperand = -2.2
        var previousResult: Double? = 1.75
        calculMath.currentOperator = "*"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, -3.85, accuracy: 0.0001, "Multipl 1st Positive Double 2nd Negative Double failed")
    }
    
    func testMultipl_1stNegativeInt2ndZero() {
        calculMath.currentOperand = 0
        var previousResult: Double? = -10
        calculMath.currentOperator = "*"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 0, "Multipl 1st Negative Int 2nd Zero failed")
    }
    
    func testSubtract_1stInt2ndIntResultNegative() {
        calculMath.currentOperand = 10
        var previousResult: Double? = 2
        calculMath.currentOperator = "-"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, -8, "Subtract 1st Positive Int 2nd Negative Int failed")
    }
    
    func testSubtract_1stDouble2ndDoubleResultPositive() {
        calculMath.currentOperand = 2.2
        var previousResult: Double? = 10.5
        calculMath.currentOperator = "-"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 8.3, accuracy: 0.0001, "Subtract 1st Positive Double 2nd Negative Double failed")
    }
    
    // aaa
    func testSubtract_1stNegativeInt2ndZeroResultNegative() {
        calculMath.currentOperand = 0
        var previousResult: Double? = -10
        calculMath.currentOperator = "-"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, -10, "Subtract 1st Negative Int 2nd Zero failed")
    }
    
    func testDivide_1stPositiveInt2ndPositiveIntResultPositive() {
        calculMath.currentOperand = 2
        var previousResult: Double? = 10
        calculMath.currentOperator = "/"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 5, "Divide 1st Positive Int 2nd Positive Int failed")
    }
    
    func testSubtract_1stNegativeInt2ndDoubleResultNegative() {
        calculMath.currentOperand = 2.2
        var previousResult: Double? = -10
        calculMath.currentOperator = "-"
        XCTAssertNoThrow(try {
            let result = try calculMath.calculate(previousResult: &previousResult)
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, -12.2, accuracy: 0.0001, "Subtract 1st Negative Int 2nd Negative Double failed")
    }
    
    func testSquareRoot_PositiveInt() {
        calculMath.currentOperand = 16
        calculMath.currentOperator = "√"
        XCTAssertNoThrow(try {
            let result = try calculMath.performUnaryOperation("√")
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 4.0, accuracy: 0.0001, "Square Root Positive Int failed")
    }
    
    func testSquareRoot_NegativeInt() {
        calculMath.currentOperand = -16
        calculMath.currentOperator = "√"
        XCTAssertThrowsError(try calculMath.performUnaryOperation("√")) { error in
            XCTAssertEqual(error as? CalculMathError, CalculMathError.invalidRoot)
        }
    }
    
    func testCubeRoot_PositiveInt() {
        calculMath.currentOperand = 8
        calculMath.currentOperator = "∛"
        XCTAssertNoThrow(try {
            let result = try calculMath.performUnaryOperation("∛")
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 2.0, accuracy: 0.0001, "Cube Root Positive Int failed")
    }
    
    func testPowerOfTwo_PositiveInt() {
        calculMath.currentOperand = 4
        XCTAssertNoThrow(try {
            let result = try calculMath.performUnaryOperation("2ˣ") // Assuming "2ˣ" is the operator for power of 2
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 16, "Power Of Two Positive Int failed")
    }
    
    func testPowerOfTwo_NegativeInt() {
        calculMath.currentOperand = -4
        XCTAssertNoThrow(try {
            let result = try calculMath.performUnaryOperation("2ˣ")
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 0.0625, "Power Of Two Negative Int failed")
    }
    
    func testPowerOfTwo_Zero() {
        calculMath.currentOperand = 0
        XCTAssertNoThrow(try {
            let result = try calculMath.performUnaryOperation("2ˣ")
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 1, "Power Of Two Zero failed")
    }
    
    func testPowerOfTwo_PositiveDouble() {
        calculMath.currentOperand = 5.5
        XCTAssertNoThrow(try {
            let result = try calculMath.performUnaryOperation("2ˣ")
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 45.254834, accuracy: 0.000001, "Power Of Two Positive Double failed")
    }
    
    func testPowerOfTwo_NegativeDouble() {
        calculMath.currentOperand = -2.5
        XCTAssertNoThrow(try {
            let result = try calculMath.performUnaryOperation("2ˣ")
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 0.1767766953, accuracy: 0.001, "Power Of Two Negative Double failed")
    }
    
    func testReciprocal_PositiveDouble() {
        calculMath.currentOperand = 2.5
        XCTAssertNoThrow(try {
            let result = try calculMath.performUnaryOperation("1/x") // Assuming "1/x" is the reciprocal operator
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, 0.4, accuracy: 0.001, "Reciprocal Positive Double failed")
    }
    
    func testReciprocal_Zero() {
        calculMath.currentOperand = 0
        XCTAssertThrowsError(try calculMath.performUnaryOperation("1/x")) { _ in
            XCTAssert(true)
        }
    }
    
    func testReciprocal_NegativeDouble() {
        calculMath.currentOperand = -2.5
        XCTAssertNoThrow(try {
            let result = try calculMath.performUnaryOperation("1/x")
            calculMath.currentOperand = result
        }())
        XCTAssertEqual(calculMath.currentOperand, -0.4, accuracy: 0.001, "Reciprocal Negative Double failed")
    }
}
