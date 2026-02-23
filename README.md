# Calculweb - A Feature-Rich Web Calculator
Calculweb is a fully functional web vers of calculator. It supports basic arithmetic operations, unary functions, and advanced calculations. This project demonstrates clean architecture, test-driven development, and a user-friendly interface.

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

## Installation
1.  **Clone the repository:**

    ```bash
    git clone https://github.com/tonyolyva/Calculweb.git
    ```

## Usage
* **Basic Operations:** Use the number buttons to input values, and the operation buttons (+, -, \*, /) to perform calculations. Press "=" to get the result.
* **Unary Operations:** Press the corresponding unary operation button (x², √, x³, ∛, 1/x, x!, 2ˣ, 10ˣ) to perform the operation on the current value.
* **Exponentiation:** Press the "xʸ" button, input the exponent, and press "=".
* **Decimal Input:** Press the "." button to input decimal numbers.
* **Negative Input:** Press the "-" button before inputting a number to make it negative.
* **Clear:** Press the "C" button to clear the display and reset the calculator.

## Architecture
* **`CalculwebTests`:** Unit tests to verify the calculator's functionality.
* **`CalculwebUITests`:** UI tests to verify the user interface's behavior.

## Testing
The project includes unit tests and UI tests to ensure code quality and functionality.

* **Unit Tests:** Located in the `CalculwebTests` group. These tests verify the core calculator logic and calculations.
* **UI Tests:** Located in the `CalculwebUITests` group. These tests verify the user interface's behavior and interactions.


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
