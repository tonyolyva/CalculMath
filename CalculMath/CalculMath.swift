import Foundation
import BigInt

enum CalculMathError: Error {
    case divisionByZero
    case invalidInput
    case negativeFactorial
    case invalidRoot
    case factorialOverflow
}

class CalculMath {
    var currentOperand: Double = 0
    var currentOperator: String?
    var isNegative: Bool = false
    var isDecimal: Bool = false
    var decimalPlace: Double = 10
    var inputBuffer: String = "0"
    var exponent: Double?
    var exponentBase: Double? // Store the base for exponentiation
    var isExponentPending: Bool = false // Flag to indicate exponent pending
    var isExponentNegative: Bool = false // Flag to indicate negative exponent
    var previousOperatorWasExponent: Bool = false
    var originalInput: Double?
    
    init() {}
    
    // MARK: - Input and Calculation
    
    func inputDigit(_ digit: Int) {
        if isExponentPending && exponent == nil {
            if isExponentNegative {
                exponent = -Double(digit)
                isExponentNegative = false
                inputBuffer = "-\(digit)"
            } else {
                exponent = Double(digit)
                inputBuffer += String(digit)
            }
            currentOperand = Double(inputBuffer) ?? 0.0
        } else {
            if inputBuffer == "0" || inputBuffer == "" { // Handle empty inputBuffer
                inputBuffer = String(digit)
            } else {
                inputBuffer += String(digit)
            }
            
            if let operand = Double(inputBuffer) {
                currentOperand = operand
                if isNegative {
                    currentOperand = -operand
                    isNegative = false // Reset isNegative here
                }
            }
        }
    }
    
    func inputDecimal() {
        if !inputBuffer.contains(".") {
            inputBuffer += "."
        }
    }
    
    func setDecimal() {
        if !isDecimal {
            if floor(currentOperand) == currentOperand {
                currentOperand = Double(Int(currentOperand))
            }
            isDecimal = true
            decimalPlace = 10
        }
    }
    
    func setOperator(_ op: String, previousResult: inout Double?) {
        if previousResult == nil && !(op == "-" && inputBuffer.isEmpty) {
            previousResult = currentOperand
        }
        
        if op == "^" {
            exponentBase = currentOperand
            isExponentPending = true
            currentOperator = op;
        } else if op == "-" && isExponentPending == true {
            isExponentNegative = true
        } else if op == "1/x" || op == "x!" || op == "√" || op == "x²" || op == "10ˣ" || op == "∛" {
            do {
                let result = try performUnaryOperation(op)
                currentOperand = result
                if originalInput == nil {
                    originalInput = Double(inputBuffer) ?? currentOperand
                }
            } catch {}
            currentOperator = op;
        } else if op == "2ˣ" {
            do {
                if !inputBuffer.isEmpty {
                    currentOperand = Double(inputBuffer) ?? 0
                }
                let result = try performUnaryOperation(op)
                currentOperand = result
            } catch {}
            currentOperator = op;
        } else if op == "=" {
            currentOperator = nil
            originalInput = nil
        } else {
            if !isNegative {
                currentOperator = op
                previousOperatorWasExponent = false
            }
        }
        
        if !inputBuffer.isEmpty {
            currentOperand = Double(inputBuffer) ?? 0
            if isNegative {
                currentOperand = -currentOperand
                isNegative = false
            }
        }
        isDecimal = false
        decimalPlace = 10
        
        if op == "-" && currentOperand == 0 && inputBuffer == "0" { // Corrected line
            isNegative = true;
            currentOperator = nil;
        }
        
        // Force currentOperator to nil when "-" is pressed first
        if op == "-" && currentOperand == 0 && inputBuffer == "0" {
            currentOperator = nil
        }
    }
    
    func calculate(previousResult: inout Double?) throws -> Double {
        if isExponentPending {
            
            guard let base = exponentBase, let exp = exponent else {
                throw CalculMathError.invalidInput
            }
            
            let exponentValue = isExponentNegative ? -exp : exp
            currentOperand = pow(base, exponentValue)
            isExponentPending = false
            isExponentNegative = false
            exponentBase = nil
            exponent = nil
            currentOperator = nil // Moved this line here
            return currentOperand // Moved this line here
        }
        
        guard let op = currentOperator else {
            throw CalculMathError.invalidInput
        }
        
        guard let previous = previousResult else {
            throw CalculMathError.invalidInput
        }
        
        switch op {
        case "+":
            let result = previous + currentOperand
            previousResult = result // Update previousResult
            return result
        case "-":
            let result = previous - currentOperand
            previousResult = result // Update previousResult
            return result // uncomment for pass (after collect error will done)
//            return result + 1 // remove this line & uncomment the line above after failed test info is collected
        case "*":
            let result = previous * currentOperand
            previousResult = result // Update previousResult
            return result
        case "/":
            guard currentOperand != 0 else {
                throw CalculMathError.divisionByZero
            }
            let result = previous / currentOperand
            previousResult = result // Update previousResult
            return result // uncomment for pass (after collect error will done)
//            return result - 1 // remove this line & uncomment the line above after failed test info is collected
        case "^":
            // This case should not be reached if isExponentPending is correctly handled
            throw CalculMathError.invalidInput
        default:
            throw CalculMathError.invalidInput
        }
    }
    
    func performUnaryOperation(_ op: String, operand: Double? = nil) throws -> Double {
        var currentOperand = operand ?? self.currentOperand
        switch op {
        case "x²":
            currentOperand = currentOperand * currentOperand
        case "√":
            guard currentOperand >= 0 else {
                throw CalculMathError.invalidRoot
            }
            currentOperand = sqrt(currentOperand)
        case "∛":
            currentOperand = cbrt(currentOperand)
        case "2ˣ":
            currentOperand = pow(2, currentOperand)
        case "x³":
            currentOperand = pow(currentOperand, 3)
        case "1/x":
            guard currentOperand != 0 else {
                throw CalculMathError.divisionByZero
            }
            currentOperand = 1 / currentOperand
        case "10ˣ":
//            currentOperand = pow(10, currentOperand) // uncomment for pass (after collect error will done)
            currentOperand = pow(1, currentOperand) // remove this line & uncomment the line above after failed test info is collected
        case "x!":
            if isNegative {
                isNegative = false
                throw CalculMathError.negativeFactorial
            }
            guard currentOperand >= 0 else {
                throw CalculMathError.negativeFactorial
            }
            if floor(currentOperand) != currentOperand {
                throw CalculMathError.invalidInput
            }
            let intOperand = Int(currentOperand)
            guard intOperand <= 20 else {
                throw CalculMathError.factorialOverflow
            }
            currentOperand = Double(try factorial(intOperand))
        default:
            throw CalculMathError.invalidInput
        }
        return currentOperand
    }
    
    func factorial(_ n: Int) throws -> BigInt {
        guard n >= 0 else {
            throw CalculMathError.negativeFactorial
        }
        if n == 0 {
            return 1
        }
        var result: BigInt = 1
        for i in 1...n {
            result *= BigInt(i)
        }
        return result
    }
    
    // MARK: - Clear
    
    func clear() {
        currentOperand = 0
        inputBuffer = ""
        isDecimal = false
        decimalPlace = 10
        exponent = nil
        exponentBase = nil
        isExponentPending = false
        isExponentNegative = false
        currentOperator = nil
        isNegative = false
    }
    
    func clearOperator() {
        currentOperator = nil
    }
    
    func clearInputBuffer() {
        inputBuffer = "0"
    }
}
