// Write program using this keyword when we click on button, it should be disappear.

let bt = document.querySelector("#btn2");

bt.addEventListener("click", function () {
    this.style.display = "none";
});



// Invoke a function using call() and apply(). Also Spot the difference between them.




let person = {
    name: "Shivam"
};

function greet() {
    console.log("Hello " + this.name);
}
greet.call(person);
greet.apply(person);

// Write a program for COUNTER. Whenever we click on a "Count" button, value should increment.

let btn3 = document.querySelector("#btn3");
let count = 0 ;
btn3.addEventListener("click",  ()=> {
    count++ ;
    btn3.innerText =  count ;
})


// Constructor function
function Person(name) {
    this.name = name;
}

// Add properties using prototype
Person.prototype.age = 24;
Person.prototype.city = "Hyderabad";

// Create object
let p1 = new Person("Shivam");

// Display properties
console.log("Name:", p1.name);
console.log("Age:", p1.age);
console.log("City:", p1.city);