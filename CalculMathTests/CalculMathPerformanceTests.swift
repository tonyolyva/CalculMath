import XCTest
@testable import CalculMath

final class CalculMathPerformanceTests: XCTestCase {

    var calculMath: CalculMath!

    override func setUpWithError() throws {
        calculMath = CalculMath()
    }

    override func tearDownWithError() throws {
        calculMath = nil
    }

    func testAdditionPerformance() {
        calculMath.currentOperator = "+"
        measure {
            for _ in 0..<10_000 {
                calculMath.currentOperand = 123.456
                var previousResult: Double? = 654.321
                try? _ = calculMath.calculate(previousResult: &previousResult)
            }
        }
    }

    func testUnaryOperationPerformance() {
        measure {
            for i in 1..<10_000 {
                calculMath.currentOperand = Double(i)
                try? _ = calculMath.performUnaryOperation("√")
            }
        }
    }
}
