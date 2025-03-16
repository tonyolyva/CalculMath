# CalculMath - A Feature-Rich iOS Calculator
CalculMath is a fully functional iOS calculator application built using Swift and SwiftUI. It supports basic arithmetic operations, unary functions, and advanced calculations. This project demonstrates clean architecture, test-driven development, and a user-friendly interface.

## Features
* **Basic Arithmetic Operations:** Addition, subtraction, multiplication, and division.
* **Unary Operations:**
    * Square (x²)
    * Square root (√)
    * Cube (x³)
    * Cube root (∛)
    * Reciprocal (1/x)
    * Factorial (x!)
    * Power of two (2ˣ)
    * Power of ten (10ˣ)
* **Exponentiation:** xʸ (power function)
* **Decimal Input:** Supports decimal numbers and negative inputs.
* **Clear Functionality:** Clears the display and resets the calculator.
* **Error Handling:** Handles division by zero, invalid input, and other potential errors.
* **Clean Architecture:** Uses a ViewModel to separate UI logic from business logic.
* **Test-Driven Development:** Includes unit tests and UI tests to ensure code quality.
* **SwiftUI:** Built with SwiftUI for a modern and declarative UI.

## Screenshots
addition-positive-numbers: 3 + 5 = 8 https://github.com/tonyolyva/CalculMath/Screenshots/addition-positive-numbers.png
clear-button: C -> 0 https://github.com/tonyolyva/CalculMath/Screenshots/clear-button.png
division-by-zero-error: 150 / 0 = ERROR https://github.com/tonyolyva/CalculMath/Screenshots/division-by-zero-error.png
exponentiation-calculation: 2^15 = 32,768 https://github.com/tonyolyva/CalculMath/Screenshots/exponentiation-calculation.png
factorial-calculation: 10! = 36288008 https://github.com/tonyolyva/CalculMath/Screenshots/factorial-calculation.png
multiplication-decimals: 2.25 * 5.55 = 7.75 https://github.com/tonyolyva/CalculMath/Screenshots/multiplication-decimals.png
power-of-two-calculation: 2 ^ 10 = 1,024 https://github.com/tonyolyva/CalculMath/Screenshots/power-of-two-calculation.png
square-operation: 4 ^ 2 = 16 https://github.com/tonyolyva/CalculMath/Screenshots/square-operation.png
square-root-operation: v 1024 = 32 https://github.com/tonyolyva/CalculMath/Screenshots/square-root-operation.png
subtraction-negative-numbers: 120 - 25 = -45 https://github.com/tonyolyva/CalculMath/Screenshots/subtraction-negative-numbers.png
ui-tests-passed: All UI tests Psss https://github.com/tonyolyva/CalculMath/Screenshots/ui-tests-passed.png
unit-tests-passed: All Unit tests Pass https://github.com/tonyolyva/CalculMath/Screenshots/.png

## Installation
1.  **Clone the repository:**

    ```bash
    git clone https://github.com/tonyolyva/CalculMath.git
    ```

2.  **Open the project in Xcode:**

    ```bash
    open CalculMath.xcodeproj
    ```

3.  **Build and run the app:**
    * Select a simulator or connect your iOS device.
    * Press `Command + R` to build and run the app.

## Usage
* **Basic Operations:** Use the number buttons to input values, and the operation buttons (+, -, \*, /) to perform calculations. Press "=" to get the result.
* **Unary Operations:** Press the corresponding unary operation button (x², √, x³, ∛, 1/x, x!, 2ˣ, 10ˣ) to perform the operation on the current value.
* **Exponentiation:** Press the "xʸ" button, input the exponent, and press "=".
* **Decimal Input:** Press the "." button to input decimal numbers.
* **Negative Input:** Press the "-" button before inputting a number to make it negative.
* **Clear:** Press the "C" button to clear the display and reset the calculator.

## Architecture
* **`ContentView.swift`:** Contains the SwiftUI view for the calculator's UI.
* **`CalculMathViewModel.swift`:** Manages the calculator's state and logic, acting as the ViewModel.
* **`CalculMath.swift`:** Encapsulates the core calculator logic and calculations.
* **`CalculMathButton.swift`:** Custom button used in the UI.
* **`CalculMathTests`:** Unit tests to verify the calculator's functionality.
* **`CalculMathUITests`:** UI tests to verify the user interface's behavior.

## Testing
The project includes unit tests and UI tests to ensure code quality and functionality.

* **Unit Tests:** Located in the `CalculMathTests` group. These tests verify the core calculator logic and calculations.
* **UI Tests:** Located in the `CalculMathUITests` group. These tests verify the user interface's behavior and interactions.

To run the tests:
1.  Open the project in Xcode.
2.  Press `Command + U` to run all tests.

## Dependencies
* **SwiftUI:** Used for building the user interface.
* **BigInt:** Used for handling large factorial calculations.

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Author
* tonyolyva
* GitHub Profile: https://github.com/tonyolyva/

## Contact
* olyvatony@gmail.com
* https://www.linkedin.com/in/anatoliy-olyva-a9b3b718b/

## Acknowledgments
* Used BigInt librariy for Factorial functionality