import Foundation
import BigInt

enum CalculMathError: Error {
    case divisionByZero
    case invalidInput
    case negativeFactorial
    case invalidRoot
}

class CalculMath {
    var currentOperand: Double = 0
    var previousOperand: Double?
    var currentOperator: String?
    var isNegative: Bool = false
    var isDecimal: Bool = false
    var decimalPlace: Double = 10
    var inputBuffer: String = ""
    
    init() {
        print("CalculMath initialized.")
        print("currentOperand: \(currentOperand)")
        print("isDecimal: \(isDecimal)")
        print("decimalPlace: \(decimalPlace)")
        print("isNegative: \(isNegative)")
    }
    
    // MARK: - Input and Calculation
    
    func inputDigit(_ digit: Int) {
        inputBuffer += String(digit) // Append the digit to the inputBuffer
    }
    
    func setDecimal() {
        print("setDecimal() is called (point1). currentOperand: \(currentOperand) isDecimal: \(isDecimal)  decimalPlace: \(decimalPlace) isNegative: \(isNegative)")
        if !isDecimal {
            if floor(currentOperand) == currentOperand {
                currentOperand = Double(Int(currentOperand))
            }
            isDecimal = true
            decimalPlace = 10
        }
    }
    
    func setOperator(_ op: String) {
        print("setOperator called with op: \(op)")
        if !inputBuffer.isEmpty {
            print("  inputBuffer: \(inputBuffer)")

            if previousOperand == nil {
                print("  currentOperand before setting previousOperand: \(currentOperand)")
                previousOperand = currentOperand
                print("  previousOperand set to: \(previousOperand)")
            }

            if currentOperator != nil {
                print("  currentOperator: \(currentOperator)")
                print("  previousOperand before calculate: \(previousOperand)")
                print("  currentOperand before calculate: \(currentOperand)")
                do {
                    currentOperand = try calculate()
                    print("  currentOperand after calculate: \(currentOperand)")
                } catch {
                    print("  Error in calculate: \(error)")
                }

                previousOperand = currentOperand
                print("  previousOperand after calculate: \(previousOperand)")
            } else {
                currentOperand = Double(inputBuffer) ?? 0
                if isNegative {
                    currentOperand = -currentOperand
                    isNegative = false
                }
                print("  currentOperand set to: \(currentOperand)")
            }
            inputBuffer = ""
            isDecimal = false
        }
        decimalPlace = 10

        if op == "-" && currentOperand == 0 && previousOperand == nil {
            isNegative = true
            print("  isNegative set to: \(isNegative)")
        }
        if op == "1/x" || op == "x!" || op == "√" || op == "2ˣ" || op == "x³" || op == "∛" || op == "x²" { // Added x² here.
            do {
                currentOperand = try performUnaryOperation(op)
                print("currentOperand after \(op): \(currentOperand)")
            } catch {
                print("Error in unary operation: \(error)")
            }
        }
        else if op == "=" {
            if previousOperand != nil, currentOperator != nil {
                print("  previousOperand before calculate: \(previousOperand)")
                print("  currentOperand before calculate: \(currentOperand)")
                do {
                    currentOperand = try calculate()
                    print("  currentOperand after calculate: \(currentOperand)")
                } catch {
                    print("  Error in calculate: \(error)")
                }
                previousOperand = currentOperand
                currentOperator = nil
                print("  previousOperand after calculate: \(previousOperand)")
                print("  currentOperator set to nil")
            }
        } else {
            // Change is here
            if previousOperand == nil && currentOperand != 0{
                previousOperand = currentOperand
                print("  previousOperand set to currentOperand: \(previousOperand)")
            } else if currentOperator != nil {
                previousOperand = currentOperand
                print("  previousOperand set to currentOperand because currentOperator exists: \(previousOperand)")
            } else if !inputBuffer.isEmpty {
                previousOperand = currentOperand
                print("  previousOperand set to currentOperand because inputBuffer is not empty: \(previousOperand)")
            }
            currentOperator = op
            print("  currentOperator set to: \(currentOperator)")
        }
    }
    
    /*
    func setOperator(_ op: String) {
        print("setOperator called with op: \(op)")
        if !inputBuffer.isEmpty {
            print("  inputBuffer: \(inputBuffer)")

            if previousOperand == nil {
                print("  currentOperand before setting previousOperand: \(currentOperand)")
                previousOperand = currentOperand
                print("  previousOperand set to: \(previousOperand)")
            }

            if currentOperator != nil {
                print("  currentOperator: \(currentOperator)")
                print("  previousOperand before calculate: \(previousOperand)")
                print("  currentOperand before calculate: \(currentOperand)")
                do {
                    currentOperand = try calculate()
                    print("  currentOperand after calculate: \(currentOperand)")
                } catch {
                    print("  Error in calculate: \(error)")
                }

                previousOperand = currentOperand
                print("  previousOperand after calculate: \(previousOperand)")
            } else {
                currentOperand = Double(inputBuffer) ?? 0
                if isNegative {
                    currentOperand = -currentOperand
                    isNegative = false
                }
                print("  currentOperand set to: \(currentOperand)")
            }
            inputBuffer = ""
            isDecimal = false
        }
        decimalPlace = 10

        if op == "-" && currentOperand == 0 && previousOperand == nil {
            isNegative = true
            print("  isNegative set to: \(isNegative)")
        }
        if op == "1/x" || op == "x!" || op == "√" || op == "2ˣ" || op == "x³" || op == "∛" { // Added x³ and ∛ here.
            do {
                currentOperand = try performUnaryOperation(op)
                print("currentOperand after \(op): \(currentOperand)")
            } catch {
                print("Error in unary operation: \(error)")
            }
        }
        else if op == "=" {
            if previousOperand != nil, currentOperator != nil {
                print("  previousOperand before calculate: \(previousOperand)")
                print("  currentOperand before calculate: \(currentOperand)")
                do {
                    currentOperand = try calculate()
                    print("  currentOperand after calculate: \(currentOperand)")
                } catch {
                    print("  Error in calculate: \(error)")
                }
                previousOperand = currentOperand
                currentOperator = nil
                print("  previousOperand after calculate: \(previousOperand)")
                print("  currentOperator set to nil")
            }
        } else {
            // Change is here
            if previousOperand == nil && currentOperand != 0{
                previousOperand = currentOperand
                print("  previousOperand set to currentOperand: \(previousOperand)")
            } else if currentOperator != nil {
                previousOperand = currentOperand
                print("  previousOperand set to currentOperand because currentOperator exists: \(previousOperand)")
            } else if !inputBuffer.isEmpty {
                previousOperand = currentOperand
                print("  previousOperand set to currentOperand because inputBuffer is not empty: \(previousOperand)")
            }
            currentOperator = op
            print("  currentOperator set to: \(currentOperator)")
        }
    }
 
    
 */
    func calculate() throws -> Double {
        guard let op = currentOperator, let previous = previousOperand else {
            throw CalculMathError.invalidInput
        }
        print("  calculate called with op: \(op)") // Added print
        print("  previousOperand in calculate: \(previous)") // Added print
        print("  currentOperand in calculate: \(currentOperand)") // Added print
        
        switch op {
        case "+":
            currentOperand = add(previous, currentOperand)
        case "-":
            currentOperand = subtract(previous, currentOperand)
        case "*":
            currentOperand = multiply(previous, currentOperand)
        case "/":
            guard currentOperand != 0 else {
                throw CalculMathError.divisionByZero
            }
            currentOperand = divide(previous, currentOperand)
        case "^":
            currentOperand = pow(previous, currentOperand)
        case "√":
            guard currentOperand >= 0 else {
                throw CalculMathError.invalidRoot
            }
            currentOperand = sqrt(currentOperand)
        default:
            throw CalculMathError.invalidInput
        }
        
        print("  currentOperand in calculate after operation: \(currentOperand)") // Added print
        return currentOperand
    }
    
    func performUnaryOperation(_ op: String) throws -> Double {
        print("performUnaryOperation called with: \(op), currentOperand: \(currentOperand)")
        switch op {
        case "1/x":
            return try reciprocal(currentOperand)
        case "x!":
            if floor(currentOperand) != currentOperand || currentOperand < 0 {
                throw CalculMathError.invalidInput
            }
            return Double(try factorial(Int(currentOperand)).description) ?? 0
        case "√":
            return try squareRoot(currentOperand)
        case "2ˣ":
            return pow(2, currentOperand)
        case "x³":
            return cube(currentOperand)
        case "∛":
            return try cubeRoot(currentOperand)
        case "x²": // Add this case
            return square(currentOperand)
        default:
            throw CalculMathError.invalidInput
        }
    }
    
    /*
    func performUnaryOperation(_ op: String) throws -> Double {
        print("performUnaryOperation called with: \(op), currentOperand: \(currentOperand)")
        switch op {
        case "1/x":
            return try reciprocal(currentOperand)
        case "x!":
            if floor(currentOperand) != currentOperand || currentOperand < 0 {
                throw CalculMathError.invalidInput
            }
            return Double(try factorial(Int(currentOperand)).description) ?? 0
        case "√":
            return try squareRoot(currentOperand)
        case "2ˣ":
            return pow(2, currentOperand)
        case "x³": // Add this case
            return cube(currentOperand)
        case "∛": // Add this case
            return try cubeRoot(currentOperand)
        default:
            throw CalculMathError.invalidInput
        }
    }

*/
    
    // MARK: - Basic Arithmetic Operations
    
    func add(_ a: Double, _ b: Double) -> Double {
        return a + b
    }
    
    func subtract(_ a: Double, _ b: Double) -> Double {
        return a - b
    }
    
    func multiply(_ a: Double, _ b: Double) -> Double {
        return a * b
    }
    
    func divide(_ a: Double, _ b: Double) -> Double {
        if b == 0 {
            return Double.nan
        }
        return a / b
    }
    
    // MARK: - Additional Functions
    
    func square(_ x: Double) -> Double {
        return x * x
    }
    
    func squareRoot(_ x: Double) throws -> Double {
        guard x >= 0 else {
            throw CalculMathError.invalidRoot
        }
        return sqrt(x)
    }
    
    func cube(_ x: Double) -> Double {
        return x * x * x
    }
    
    func cubeRoot(_ x: Double) throws -> Double {
        guard x >= 0 else {
            throw CalculMathError.invalidInput
        }
        return pow(x, 1.0 / 3.0)
    }
    
    func reciprocal(_ x: Double) throws -> Double {
        guard x != 0 else {
            throw CalculMathError.divisionByZero
        }
        return 1.0 / x
    }
    
    func factorial(_ n: Int) throws -> BigInt {
        
        guard n >= 0 else {
            throw CalculMathError.negativeFactorial
        }
        if n == 0 {
            return BigInt(1)
        } else {
            return BigInt(n) * (try factorial(n - 1))
        }
    }
    
    
    func powerOfTen(_ x: Double) -> Double {
        return pow(10, x)
    }
    
    func powerOfTwo(_ x: Double) -> Double {
        return pow(2, x)
    }
    
    // MARK: - Clear
    func clear() {
        print("clear() is called (begin). decimalPlace: \(decimalPlace)")
        currentOperand = 0
        inputBuffer = ""
        isDecimal = false
        decimalPlace = 10
        currentOperator = nil
        previousOperand = nil // Reset previousOperand here
        isNegative = false
        print("clear() is called (end). decimalPlace: \(decimalPlace)")
    }
}
