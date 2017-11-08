// Function.prototype.inherits = function(parent) {
//   const Surrogate = function() {};
//   Surrogate.prototype = parent.prototype;
//   this.prototype = new Surrogate();
//   this.prototype.constructor = this;
// };


Function.prototype.inherits = function(parent) {
  this.prototype = Object.create(parent.prototype);
  this.prototype.constructor = this;
};


function Dog(name) {
  this.name = name;
}

Dog.prototype.bark = function bark() {
  console.log(this.name + " barks!");
};

function Corgi(name) {
  Dog.call(this, name);
}

Corgi.inherits(Dog);

Corgi.prototype.waddle = function waddle() {
  console.log(this.name + " waddles!");
};

const blixa = new Corgi("Blixa");
blixa.bark();
blixa.waddle();


// function MovingObject () {}
//
// function Ship () {}
// Ship.inherits(MovingObject);
//
// function Asteroid () {}
// Asteroid.inherits(MovingObject);
//
// Asteroid.prototype.test = function () {
//   console.log("I'm an asteroid.");
// };
//
// MovingObject.prototype.nottest = function () {
//   console.log("I'm a moving object.");
// };
