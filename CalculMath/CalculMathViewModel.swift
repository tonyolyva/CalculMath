import Combine
import SwiftUI

class CalculMathViewModel: ObservableObject {
    @Published var displayValue: String = "0"
    var calculMath = CalculMath()
    var previousResult: Double? // Add previousResult property
    
    func buttonPressed(button: String) {
        print("buttonPressed: \(button)")
        print("currentOperand before: \(calculMath.currentOperand)")
        
        if let digit = Int(button) {
            calculMath.inputDigit(digit)
            if let operand = Double(calculMath.inputBuffer) {
                calculMath.currentOperand = operand
                if calculMath.isNegative {
                    calculMath.currentOperand = -calculMath.currentOperand
                }
                displayValue = formatOperand(calculMath.currentOperand)
            }
        } else {
            switch button {
            case "+", "-", "*", "/", "^":
                if let previous = previousResult {
                    calculMath.currentOperand = previous
                    calculMath.inputBuffer = String(previous)
                }
                calculMath.setOperator(button)
                previousResult = nil
                displayValue = "0"
            case "=":
                do {
                    print("previousResult before calculate: \(String(describing: previousResult))")
                    print("currentOperand before calculate: \(calculMath.currentOperand)")
                    let result = try calculMath.calculate()
                    previousResult = result
                    calculMath.currentOperand = result
                    calculMath.inputBuffer = String(result)
                    print("previousResult after calculate: \(String(describing: previousResult))")
                    print("currentOperand after calculate: \(calculMath.currentOperand)")
                    displayValue = formatResult(result)
                } catch {
                    displayValue = "Error"
                }
            case "x²":
                let result = calculMath.square(calculMath.currentOperand)
                displayValue = formatResult(result)
                calculMath.currentOperand = result
                calculMath.setOperator("x²")
                print("currentOperand after x²: \(calculMath.currentOperand)")
            case "√":
                do {
                    let result = try calculMath.squareRoot(calculMath.currentOperand)
                    displayValue = formatResult(result)
                    calculMath.currentOperand = result
                    calculMath.setOperator("√")
                } catch {
                    displayValue = "Error"
                }
            case "∛":
                do {
                    let result = try calculMath.cubeRoot(calculMath.currentOperand)
                    displayValue = formatResult(result)
                    calculMath.currentOperand = result
                    calculMath.setOperator("∛")
                    print("currentOperand after ∛: \(calculMath.currentOperand)")
                } catch {
                    displayValue = "Error"
                }                
            case "2ˣ":
                calculMath.setOperator("2ˣ")
                displayValue = formatResult(calculMath.currentOperand)
            case "x³":
                calculMath.setOperator("x³")
                let result = try? calculMath.cube(calculMath.currentOperand)
                if let result = result {
                    displayValue = formatResult(result)
                    calculMath.currentOperand = result // Update currentOperand ONLY ONCE!
                    print("currentOperand after x³: \(calculMath.currentOperand)")
                } else {
                    displayValue = "Error"
                }
            case "1/x":
                do {
                    let result = try calculMath.reciprocal(calculMath.currentOperand)
                    displayValue = formatResult(result)
                    calculMath.currentOperand = result
                    calculMath.setOperator("1/x")
                } catch {
                    displayValue = "Error"
                }
            case "10ˣ":
                let result = calculMath.powerOfTen(calculMath.currentOperand)
                displayValue = formatResult(result)
                calculMath.currentOperand = result
                calculMath.setOperator("10ˣ")
                print("currentOperand after 10ˣ: \(calculMath.currentOperand)")
            case "x!":
                do {
                    let result = try calculMath.factorial(Int(calculMath.currentOperand))
                    displayValue = String(result)
                    if let doubleResult = Double(result.description) {
                        calculMath.currentOperand = doubleResult
                        calculMath.setOperator("x!")
                        print("currentOperand after x!: \(calculMath.currentOperand)")
                    } else {
                        displayValue = "Error"
                    }
                } catch {
                    displayValue = "Error"
                }
            case "C":
                calculMath.clear()
                displayValue = "0"
                previousResult = nil
            case ".":
                calculMath.setDecimal()
                if calculMath.isDecimal {
                    if !calculMath.inputBuffer.contains(".") {
                        calculMath.inputBuffer += "."
                    }
                    if let operand = Double(calculMath.inputBuffer) {
                        calculMath.currentOperand = operand
                        if calculMath.isNegative {
                            calculMath.currentOperand = -calculMath.currentOperand
                        }
                        displayValue = formatOperand(calculMath.currentOperand)
                    }
                }
            default:
                break
            }
        }
        print("currentOperand after: \(calculMath.currentOperand)")
    }
    // MARK: - Helper Functions
    
    func formatOperand(_ operand: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 10 // Adjust as needed
        let formattedString = formatter.string(from: NSNumber(value: operand)) ?? "0"
        return formattedString
    }
    
    private func formatResult(_ result: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 10
        return formatter.string(from: NSNumber(value: result)) ?? String(result)
    }
}
