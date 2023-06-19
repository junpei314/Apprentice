"use strict";

const t = 29;

const checkTemperature = t => {
  if (t >= 30) {
    console.log("Hot");
  } else if (t < 30 && t >= 15) {
    console.log("Warm");
  } else {
    console.log("Cold");
  }
};

checkTemperature(t);

const n = 1242;

const checkOddOrEven = n => {
  if (n % 2 === 0) {
    console.log("even");
  } else {
    console.log("odd");
  }
};

checkOddOrEven(n);