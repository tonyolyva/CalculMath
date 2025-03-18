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
    var exponent: Double?
    var previousOperatorWasExponent: Bool = false
    var isExponentNegative: Bool = false
    var originalInput: Double? // Add this line
    
    init() {
        print("CalculMath initialized.")
        print("currentOperand: \(currentOperand)")
        print("isDecimal: \(isDecimal)")
        print("decimalPlace: \(decimalPlace)")
        print("isNegative: \(isNegative)")
    }
    
    // MARK: - Input and Calculation
    
    func inputDigit(_ digit: Int) {
        if currentOperator == "^" && exponent == nil {
            if let number = Double(String(digit)) {
                if isExponentNegative {
                    exponent = -number
                    isExponentNegative = false
                    inputBuffer = "-\(digit)"
                } else {
                    exponent = number
                    inputBuffer = "\(digit)"
                }
                currentOperand = exponent!
                print("  Exponent captured: \(exponent!)")
            }
        } else {
            inputBuffer += String(digit)
        }
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
        print("  currentOperand: \(currentOperand), previousOperand: \(previousOperand), inputBuffer: \(inputBuffer)")
        
        if !inputBuffer.isEmpty {
            print("  inputBuffer: \(inputBuffer)")
            if previousOperand == nil {
                print("  currentOperand before setting previousOperand: \(currentOperand)")
                print("  previousOperand set to: \(previousOperand)")
                currentOperand = Double(inputBuffer) ?? 0
                if isNegative {
                    currentOperand = -currentOperand
                    isNegative = false
                }
                inputBuffer = ""
            } else if currentOperator != nil {
                currentOperand = Double(inputBuffer) ?? 0
                if isNegative {
                    currentOperand = -currentOperand
                    isNegative = false
                }
                print("  currentOperand set to: \(currentOperand)")
                inputBuffer = ""
            } else {
                currentOperand = Double(inputBuffer) ?? 0
                if isNegative {
                    currentOperand = -currentOperand
                    isNegative = false
                }
                print("  currentOperand set to: \(currentOperand)")
                inputBuffer = ""
            }
            isDecimal = false
        }
        
        decimalPlace = 10
        
        if op == "-" && currentOperand == 0 && previousOperand == nil {
            isNegative = true
            print("  isNegative set to: \(isNegative)")
        } else {
            isNegative = false
        }
        
        if op == "^" {
            if !inputBuffer.isEmpty {
                currentOperand = Double(inputBuffer) ?? 0
                inputBuffer = ""
            }
            previousOperand = currentOperand
            currentOperator = op
            exponent = nil
            print("  Exponent operator set. Waiting for exponent input.")
            previousOperatorWasExponent = true
        } else if op == "-" && previousOperatorWasExponent {
            // Treat as negative exponent
            isExponentNegative = true
            inputBuffer = ""
        } else if op == "1/x" || op == "x!" || op == "√" || op == "x²" || op == "10ˣ" || op == "∛" {
            do {
                print("  currentOperand before performUnaryOperation: \(currentOperand)")
                let result = try performUnaryOperation(op)
                print("performUnaryOperation(\(op)) returned: \(result)")
                currentOperand = result
                print("  currentOperand after \(op): \(currentOperand)")
                print("  currentOperand after assignment: \(currentOperand)")
                if originalInput == nil {
                    originalInput = Double(inputBuffer) ?? currentOperand
                }
                
            } catch {
                print("Error in unary operation: \(error)")
            }
        } else if op == "2ˣ" {
            do {
                if !inputBuffer.isEmpty {
                    currentOperand = Double(inputBuffer) ?? 0
                    inputBuffer = ""
                }
                currentOperand = try performUnaryOperation(op)
                print("performUnaryOperation(\(op)) returned: \(currentOperand)")
                print("currentOperand after \(op): \(currentOperand)")
            } catch {
                print("Error in unary operation: \(error)")
            }
        } else if op == "=" {
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
            originalInput = nil
        } else if op == "-" {
            if previousOperand == nil {
                isNegative = true
            } else {
                previousOperand = currentOperand
                currentOperator = op
                inputBuffer = ""
                previousOperatorWasExponent = false
            }
        } else {
            if previousOperand == nil && currentOperand != 0 {
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
            previousOperatorWasExponent = false
        }
        
        print("  currentOperand after setOperator: \(currentOperand), previousOperand: \(previousOperand), inputBuffer: \(inputBuffer)")
    }
    
    func calculate() throws -> Double {
        guard let op = currentOperator, let previous = previousOperand else {
            throw CalculMathError.invalidInput
        }
        print("  calculate called with op: \(op)")
        print("  previousOperand in calculate: \(previous)")
        print("  currentOperand in calculate: \(currentOperand)")
        
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
            if let base = previousOperand, let exp = exponent {
                currentOperand = pow(base, exp)
                previousOperand = nil
                exponent = nil
                print("  Exponent calculation: \(base) ^ \(exp) = \(currentOperand)")
            } else if let base = previousOperand, let exp = Double(inputBuffer){
                currentOperand = pow(base, exp)
                previousOperand = nil
                exponent = nil
                print("  Exponent calculation: \(base) ^ \(exp) = \(currentOperand)")
            }
            else {
                throw CalculMathError.invalidInput
            }
        case "√":
            guard currentOperand >= 0 else {
                throw CalculMathError.invalidRoot
            }
            currentOperand = sqrt(currentOperand)
        default:
            throw CalculMathError.invalidInput
        }
        
        print("  currentOperand in calculate after operation: \(currentOperand)")
        return currentOperand
    }
    
    /*
     func performUnaryOperation(_ op: String) throws -> Double {
     print("performUnaryOperation called with: \(op), currentOperand: \(currentOperand)")
     
     switch op {
     case "1/x":
     print("Before reciprocal: \(currentOperand)")
     let result = try reciprocal(currentOperand)
     print("After reciprocal: \(result)")
     return result
     case "x!":
     if floor(currentOperand) != currentOperand || currentOperand < 0 {
     throw CalculMathError.invalidInput
     }
     return Double(try factorial(Int(currentOperand)).description) ?? 0
     case "√":
     print("Before squareRoot: \(currentOperand)")
     let result = try squareRoot(currentOperand)
     print("After squareRoot: \(result)")
     return result
     case "2ˣ":
     print("  Before 2ˣ: \(currentOperand)")
     let result = pow(2, currentOperand)
     print("  After 2ˣ: \(result)")
     return result
     case "x³":
     return cube(currentOperand)
     case "∛":
     print("  Before ∛: \(currentOperand)")
     let result = try cubeRoot(currentOperand)
     print("  After ∛: \(result)")
     return result
     case "x²": // Add this case
     return square(currentOperand)
     case "10ˣ":
     print("Before powerOfTen: \(currentOperand)")
     let result = powerOfTen(currentOperand)
     print("After powerOfTen: \(result)")
     return result;
     default:
     throw CalculMathError.invalidInput
     }
     print("performUnaryOperation result: \(currentOperand)")
     }
     
     */
    
    func performUnaryOperation(_ op: String) throws -> Double {
        print("performUnaryOperation called with: \(op), currentOperand: \(currentOperand)")
        switch op {
        case "1/x":
            guard currentOperand != 0 else {
                throw CalculMathError.divisionByZero
            }
            currentOperand = 1 / currentOperand
        case "x!":
            guard currentOperand >= 0 else {
                throw CalculMathError.negativeFactorial
            }
            currentOperand = Double(try factorial(Int(currentOperand)))
        case "√":
            guard (originalInput ?? currentOperand) >= 0 else {
                throw CalculMathError.invalidRoot
            }
            print("Before squareRoot: \(originalInput ?? currentOperand)")
            currentOperand = sqrt(originalInput ?? currentOperand)
            print("After squareRoot: \(currentOperand)")
            originalInput = currentOperand
        case "x²":
            currentOperand = currentOperand * currentOperand
        case "10ˣ":
            currentOperand = pow(10, currentOperand)
        case "∛":
            currentOperand = pow(currentOperand, 1/3)
        case "2ˣ":
            currentOperand = pow(2, currentOperand)
        default:
            throw CalculMathError.invalidInput
        }
        return currentOperand
    }
    
    
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
        print("cubeRoot called with: \(x)")
        
        guard x >= 0 else {
            throw CalculMathError.invalidInput
        }
        let result = pow(x, 1.0 / 3.0)
        print("cubeRoot result: \(result)")
        return result
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
    
    // new
    func powerOfTwo(_ x: Double) throws -> Double{
        print("powerOfTwo called with: \(x)")
        let result = pow(2, x)
        print("powerOfTwo result: \(result)")
        return result
    }
    
    func powerOfTen(_ x: Double) -> Double {
        return pow(10, x)
    }
    
    // MARK: - Clear
    func clear() {
        print("clear() is called (begin). decimalPlace: \(decimalPlace)")
        currentOperand = 0
        inputBuffer = ""
        isDecimal = false
        decimalPlace = 10
        exponent = nil // Reset exponent
        currentOperator = nil
        previousOperand = nil // Reset previousOperand here
        isNegative = false
        print("clear() is called (end). decimalPlace: \(decimalPlace)")
    }
}
