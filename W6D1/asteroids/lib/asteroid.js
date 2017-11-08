const Util = require("./utils.js");
const MovingObject = require("./moving_object.js");

const Asteroid = function(pos, game) {
  MovingObject.call(this, {color: "#737982",
    radius: 30,
    pos: pos,
    game: game,
    vel: Util.randomVec(Math.random() * 10)});
};

// Return a randomly oriented vector with the given length.

Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;
