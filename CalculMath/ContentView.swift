import SwiftUI

struct CalculMathView: View {
    @ObservedObject var viewModel = CalculMathViewModel()
    @State private var displayValue: String = "0"

    
    var body: some View {
        VStack {
            Text(viewModel.displayValue)
                .frame(maxWidth: 272, alignment: .trailing)
                .padding(10)
                .background(Color.black.opacity(0.1))
                .cornerRadius(8)
                .font(.title)
                .accessibilityIdentifier("displayValue")
        }

        VStack(spacing: 8) {
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    CalculMathButton(text: "x²", action: { viewModel.buttonPressed(button: "x²") }, type: .function, size: .small)
                    CalculMathButton(text: "√", action: { viewModel.buttonPressed(button: "√") }, type: .function, size: .small)
                    CalculMathButton(text: "2ˣ", action: { viewModel.buttonPressed(button: "2ˣ") }, type: .function, size: .small)
                    CalculMathButton(text: "x³", action: { viewModel.buttonPressed(button: "x³") }, type: .function, size: .small)
                    CalculMathButton(text: "C", action: { viewModel.buttonPressed(button: "C") }, type: .clear, size: .small)
                }
                HStack(spacing: 8) {
                    CalculMathButton(text: "xʸ", action: { viewModel.buttonPressed(button: "^") }, type: .function, size: .small)
                    CalculMathButton(text: "∛", action: { viewModel.buttonPressed(button: "∛") }, type: .function, size: .small)
                    CalculMathButton(text: "1/x", action: { viewModel.buttonPressed(button: "1/x") }, type: .function, size: .small)
                    CalculMathButton(text: "x!", action: { viewModel.buttonPressed(button: "x!") }, type: .function, size: .small)
                    CalculMathButton(text: "10ˣ", action: { viewModel.buttonPressed(button: "10ˣ") }, type: .function, size: .small)
                }
                HStack(spacing: 8) {
                    CalculMathButton(text: "7", action: { viewModel.buttonPressed(button: "7") }, type: .number, size: .medium)
                    CalculMathButton(text: "8", action: { viewModel.buttonPressed(button: "8") }, type: .number, size: .medium)
                    CalculMathButton(text: "9", action: { viewModel.buttonPressed(button: "9") }, type: .number, size: .medium)
                    CalculMathButton(text: "+", action: { viewModel.buttonPressed(button: "+") }, type: .operation, size: .medium)
                }
                HStack(spacing: 8) {
                    CalculMathButton(text: "4", action: { viewModel.buttonPressed(button: "4") }, type: .number, size: .medium)
                    CalculMathButton(text: "5", action: { viewModel.buttonPressed(button: "5") }, type: .number, size: .medium)
                    CalculMathButton(text: "6", action: { viewModel.buttonPressed(button: "6") }, type: .number, size: .medium)
                    CalculMathButton(text: "-", action: { viewModel.buttonPressed(button: "-") }, type: .operation, size: .medium)
                }
                HStack(spacing: 8) {
                    CalculMathButton(text: "1", action: { viewModel.buttonPressed(button: "1") }, type: .number, size: .medium)
                    CalculMathButton(text: "2", action: { viewModel.buttonPressed(button: "2") }, type: .number, size: .medium)
                    CalculMathButton(text: "3", action: { viewModel.buttonPressed(button: "3") }, type: .number, size: .medium)
                    CalculMathButton(text: "*", action: { viewModel.buttonPressed(button: "*") }, type: .operation, size: .medium)
                }
                HStack(spacing: 8) {
                    CalculMathButton(text: "0", action: { viewModel.buttonPressed(button: "0") }, type: .number, size: .medium)
                    CalculMathButton(text: ".", action: { viewModel.buttonPressed(button: ".") }, type: .number, size: .medium)
                    CalculMathButton(text: "=", action: { viewModel.buttonPressed(button: "=") }, type: .compute, size: .medium)
                    CalculMathButton(text: "/", action: { viewModel.buttonPressed(button: "/") }, type: .operation, size: .medium)
                }
            }
            .padding()
        }
    }
}
