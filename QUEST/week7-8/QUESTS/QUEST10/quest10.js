"use strict";

const numbers = [1, 2, 3, 4, 5];

// const hasOdd = numbers => {
//   numbers.forEach(num => {
//     if(num % 2 === 1) {
//       return console.log(true)
//     }
//   })
// };

const hasOdd = numbers => {
  for (let i = 0; i <= numbers.length; i++) {
    if (numbers[i] % 2 === 1) {
      return console.log(true);
    };
  };
  return console.log(false);
};

// const hasOdd = numbers => {
//   let i = 0
//   while (numbers[i] % 2 === 0) {
//     i++
//   }
//   console.log(true);
// };


const odd = numbers => {
  let odd_numbers = [];
  for (let i = 0; i <= numbers.length; i++) {
    if (numbers[i] % 2 === 1) {
      odd_numbers.push(numbers[i]);
    };
  };
  return console.log(odd_numbers);
};


const square = numbers => {
  let square_numbers = [];
  numbers.forEach(num => {
    square_numbers.push(num ** 2);
  });
  return console.log(square_numbers);
};

hasOdd(numbers);

odd(numbers);

square(numbers);

