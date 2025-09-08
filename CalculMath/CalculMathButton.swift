import SwiftUI

struct CalculMathButton: View {
    let text: String
    let action: () -> Void
    let type: ButtonType
    let size: ButtonSize
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(type.backgroundColor)
                .foregroundColor(type.foregroundColor)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 2, y: 2)
                .accessibilityLabel(text) // accessibility label to the button's text
        }
        .frame(width: size.width, height: size.height)
    }
}

enum ButtonType {
    case number, operation, function, compute, clear
    
    var backgroundColor: Color {
        switch self {
        case .number: return Color(red: 0.3, green: 0.4, blue: 0.7)
        case .operation: return Color(red: 0.9, green: 0.6, blue: 0.2)
        case .function: return Color(red: 0.3, green: 0.3, blue: 0.6)
        case .compute: return Color(red: 0.2, green: 0.6, blue: 0.6)
        case .clear: return Color(red: 0.7, green: 0.3, blue: 0.4)
        }
    }
    
    var foregroundColor: Color {
        return .white
    }
}

enum ButtonSize {
    case small, medium
    
    var width: CGFloat {
        switch self {
        case .small: return 52
        case .medium: return 67
        }
    }
    
    var height: CGFloat {
        switch self {
        case .small: return 52
        case .medium: return 67
        }
    }
}

