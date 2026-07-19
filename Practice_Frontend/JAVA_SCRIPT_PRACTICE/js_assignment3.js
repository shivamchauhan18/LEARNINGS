let btn4 = document.getElementById("btn4");

btn4.addEventListener("click", function () {
    btn4.innerHTML = new Date();
});


// Show the javascript validation. When you click submit, the text box doesn't need to be empty.

function validate() {
    let name = document.querySelector("#name").value;

    if (name == "") {
        document.getElementById("msg").innerHTML = "Textbox cannot be empty!";
    } else {
        document.getElementById("msg").innerHTML = "Submitted Successfully";
    }
}

// How console.log() can be used for Debugging.
let a = 10;
let b = 20;

console.log("Value of a =", a);
console.log("Value of b =", b);

let sum = a + b;

console.log("Sum =", sum);


//
// Set Cookie
function setCookie() {
    document.cookie = "username=Shivam";
}

// Get Cookie
function getCookie() {
    console.log(document.cookie);
}

// Check Cookie
function checkCookie() {
    if (document.cookie != "") {
        alert("Cookie Found");
    } else {
        alert("Cookie Not Found");
    }
}

// Function Calls
setCookie();
getCookie();
checkCookie();



//
let student = {
    "name": "Shivam",
    "age": 24,
    "city": "Hyderabad"
};

console.log(student.name);
console.log(student.age);
console.log(student.city);