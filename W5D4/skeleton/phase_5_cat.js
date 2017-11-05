const Faker = require('fakergem');

const Cat = function(name, owner) {
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function() {
  return `${this.owner} diregards ${this.name}`;
};






const gen = () => Faker.LordOfTheRings.character();
let bobby = new Cat(gen(), gen());
let timmy = new Cat(gen(), gen());
let johnny = new Cat(gen(), gen());
bobby.cuteStatement();

Cat.prototype.cuteStatement = function() {
  return `Everyone loves ${this.name}`;
};

bobby.cuteStatement();

Cat.prototype.meow = function() {
  return "meow";
};

bobby.meow();

bobby.meow = function() {
  return "bobby meows";
};

bobby.meow();
timmy.meow();
