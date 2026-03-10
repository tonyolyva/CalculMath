const display = document.querySelector('[data-testid="display"]');
const buttons = document.querySelector('.calculator__keys');

let currentValue = '0';
let firstOperand = null;
let operator = null;
let waitingForSecondOperand = false;

function updateDisplay() {
  display.value = currentValue;
}

function inputDigit(digit) {
  if (waitingForSecondOperand) {
    currentValue = digit;
    waitingForSecondOperand = false;
    return;
  }

  if (currentValue === '0' && digit !== '.') {
    currentValue = digit;
  } else {
    if (digit === '.' && currentValue.includes('.')) return;
    currentValue += digit;
  }
}

function clearAll() {
  currentValue = '0';
  firstOperand = null;
  operator = null;
  waitingForSecondOperand = false;
}

function deleteLast() {
  if (waitingForSecondOperand) return;
  if (currentValue.length <= 1 || currentValue === 'Error') {
    currentValue = '0';
    return;
  }
  currentValue = currentValue.slice(0, -1);
}

function calculate(a, b, op) {
  switch (op) {
    case '+':
      return a + b;
    case '-':
      return a - b;
    case '*':
      return a * b;
    case '/':
      if (b === 0) return 'Error';
      return a / b;
    default:
      return b;
  }
}

function handleOperator(nextOperator) {
  const inputValue = parseFloat(currentValue);

  if (operator && waitingForSecondOperand) {
    operator = nextOperator;
    return;
  }

  if (firstOperand == null) {
    firstOperand = inputValue;
  } else if (operator) {
    const result = calculate(firstOperand, inputValue, operator);
    currentValue = result === 'Error' ? 'Error' : `${parseFloat(result.toFixed(8))}`;
    firstOperand = result === 'Error' ? null : parseFloat(currentValue);
  }

  waitingForSecondOperand = true;
  operator = nextOperator;
}

function handleEquals() {
  if (operator == null || firstOperand == null) return;

  const inputValue = parseFloat(currentValue);
  const result = calculate(firstOperand, inputValue, operator);

  currentValue = result === 'Error' ? 'Error' : `${parseFloat(result.toFixed(8))}`;
  firstOperand = null;
  operator = null;
  waitingForSecondOperand = false;
}

buttons.addEventListener('click', (event) => {
  const target = event.target;
  if (!(target instanceof HTMLButtonElement)) return;

  const action = target.dataset.action;
  const value = target.dataset.value;

  switch (action) {
    case 'digit':
      inputDigit(value);
      break;
    case 'operator':
      handleOperator(value);
      break;
    case 'equals':
      handleEquals();
      break;
    case 'clear':
      clearAll();
      break;
    case 'delete':
      deleteLast();
      break;
    default:
      return;
  }

  updateDisplay();
});

updateDisplay();
