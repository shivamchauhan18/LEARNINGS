// Single Line Comment

/*  
Multi
Line 
Comments

*/


// Problem 2

let  frtName = ["Mango", "Lichi", "Orange", "Apple", "Chiku"]
let btn = document.querySelector("#btn");
btn.addEventListener("click" , ()=> { frtName.sort(); frtName.reverse();
    console.log(frtName);
})


let fruits = ["Mango", "Apple", "Orange", "Lichi", "Chiku"];

for (let index in fruits) {
    console.log(index + " : " + fruits[index]);
}


// Problem 3

const Person = {

    "name": "Shivam",
    "gender": "Male",
    "City" : "Jaipur"
}

console.log(Person["name"])
console.log(Person.City)


// problem 4

x = 10

console.log("value of X = ", x)

var x


// Problem 5

"use strict";

// Declare the variable first
y = 20;

console.log(y);