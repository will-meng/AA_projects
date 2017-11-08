const Asteroid = require("./asteroid.js");



const Game = function() {
  this.asteroids = [];
  this.addAsteroids();
};

Game.DIM_X = 1000;
Game.DIM_Y = 800;
Game.NUM_ASTEROIDS = 10;

Game.prototype.addAsteroids = function() {
  for(let i = 0; i < Game.NUM_ASTEROIDS; i++) {
    this.asteroids.push(new Asteroid(this.randomPos(), this));
  }
};

Game.prototype.randomPos = function() {
  let randX = Math.random() * Game.DIM_X;
  let randY = Math.random() * Game.DIM_Y;
  return [randX, randY];
};

Game.prototype.draw = function (ctx) {
  ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
  ctx.fillStyle = "#668dcc";
  ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);
  for(let i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].draw(ctx);
  }
};

Game.prototype.moveObjects = function () {
  for(let i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].move();
  }
};

Game.prototype.wrap = function (pos) {
  let x, y;
  [x, y] = pos;
  if(x > Game.DIM_X) {
    x = x % Game.DIM_X;
    y = Game.DIM_Y - y;
  } else if(x < 0 ) {
    x += Game.DIM_X;
    y = Game.DIM_Y - y;
  }

  if(y > Game.DIM_Y) {
    y = y % Game.DIM_Y;
  } else if(y < 0 ) {
    y += Game.DIM_Y;
  }

  return [x, y];
};

module.exports = Game;
