const display = document.getElementById('display');
const buttons = document.getElementsByTagName('button');
let numbers = 0;
let numbersSaved = 0;
let operator = '';

const showDisplay = (event) => {
  if (event.target.className === 'digit') {
    if (display.textContent.search(/\D/) !== -1) {
      display.textContent = '';
      numbersSaved = numbers;
      numbers = 0;
    }
    display.textContent += event.target.textContent;
    numbers = Number(display.textContent);
  } else if (event.target.className === 'operator') {
    display.textContent += event.target.textContent;
    operator = event.target.textContent;
  } else if (event.target.id === 'clear') {
    display.textContent = '';
    numbers = 0;
  } else {
    calulator(operator);
  }
};

const calulator = (operator) => {
  switch(operator) {
    case '+':
      display.textContent = numbersSaved + numbers;
      numbers += numbersSaved;
      break;  
    case '-':
      display.textContent = numbersSaved - numbers;
      numbers = numbersSaved -numbers;
      break;  
    case '*':
      display.textContent = numbersSaved * numbers;
      numbers *= numbersSaved;
      break;  
    case '/':
      display.textContent = numbersSaved / numbers;
      numbers = numbersSaved / numbers;
      break;     
}
};

for (let i = 0; buttons.length > i; i++) {
  buttons[i].addEventListener('click', showDisplay)
};