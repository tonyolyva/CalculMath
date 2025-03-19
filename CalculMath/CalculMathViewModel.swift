import SwiftUI
import Foundation

class CalculMathViewModel: ObservableObject {
    @Published var displayValue: String = "0"
    var calculMath = CalculMath()
    var previousResult: Double?
    
    // MARK: - Helper Functions
    
    func formatOperand(_ operand: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 10
        formatter.alwaysShowsDecimalSeparator = false
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale.current
        
        let formattedString = formatter.string(from: NSNumber(value: operand))! // Force unwrap
        
        return formattedString
    }
    
    private func formatResult(_ result: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal // Explicitly specify the type
        formatter.maximumFractionDigits = 10
        return formatter.string(from: NSNumber(value: result)) ?? String(result)
    }
    
    func buttonPressed(button: String) {
        
        if Int(button) != nil { // Changed if let digit to if Int(button) != nil
            if calculMath.currentOperator == "^" && calculMath.exponent == nil {
                if calculMath.isExponentNegative {
                    calculMath.exponent = -Double(button)!
                    calculMath.isExponentNegative = false
                    calculMath.inputBuffer = "-\(button)"
                } else {
                    calculMath.exponent = Double(button)!
                    calculMath.inputBuffer += String(button)
                }
                calculMath.currentOperand = Double(calculMath.inputBuffer) ?? 0.0
                displayValue = formatOperand(calculMath.currentOperand)
            } else {
                calculMath.inputDigit(Int(button)!)
                if let operand = Double(calculMath.inputBuffer) {
                    displayValue = formatOperand(calculMath.currentOperand)
                } else if calculMath.inputBuffer.hasPrefix("-") && calculMath.inputBuffer.count > 1 {
                    if let operand = Double(calculMath.inputBuffer) {
                        calculMath.currentOperand = operand
                        displayValue = formatOperand(calculMath.currentOperand)
                    }
                } else {
                    displayValue = "0"
                }
            }
        } else {
            switch button {
            case "+", "-", "*", "/", "^":
                if !(button == "-" && calculMath.currentOperand == 0 && calculMath.inputBuffer.isEmpty) {
                    calculMath.setOperator(button, previousResult: &previousResult)
                    calculMath.inputBuffer = ""
                    calculMath.isDecimal = false
                    calculMath.decimalPlace = 10
                    displayValue = "0"
                } else {
                    calculMath.setOperator(button, previousResult: &previousResult)
                    displayValue = "0"
                }
                break
            case "=":
                do {
                    let result = try calculMath.calculate(previousResult: &previousResult)
                    previousResult = result
                    calculMath.currentOperand = result
                    calculMath.inputBuffer = String(result)
                    calculMath.currentOperator = nil
                    if result.truncatingRemainder(dividingBy: 1) == 0 {
                        displayValue = String(Int(result))
                    } else {
                        displayValue = String(result)
                    }
                } catch {
                    displayValue = "Error"
                }
                break
            case "C":
                calculMath.clear()
                displayValue = "0"
                previousResult = nil
                break
            case ".":
                calculMath.inputDecimal()
                if let operand = Double(calculMath.inputBuffer) {
                    calculMath.currentOperand = operand
                    displayValue = formatOperand(calculMath.currentOperand)
                } else {
                    displayValue = calculMath.inputBuffer
                }
                break
            case "√", "x²", "x³", "1/x", "x!", "10ˣ", "∛", "2ˣ":
                do {
                    let result = try calculMath.performUnaryOperation(button)
                    calculMath.currentOperand = result
                    calculMath.inputBuffer = String(result)
                    displayValue = formatOperand(result)
                } catch {
                    displayValue = "Error"
                }
                break
            default:
                break
            }
        }
    }
}
