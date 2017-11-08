const MovingObject = function(options) {
  this.pos = options.pos;
  this.vel = options.vel;
  this.radius = options.radius;
  this.color = options.color;
  this.game = options.game;
};

MovingObject.prototype.move = function () {
  let x, y, vx, vy;
  // debugger;
  [x, y] = this.pos;
  [vx, vy] = this.vel;
  this.pos = this.game.wrap([x + vx, y + vy]);
};

MovingObject.prototype.draw = function (ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();

  ctx.arc(
    this.pos[0],
    this.pos[1],
    this.radius,
    0,
    2 * Math.PI,
    false
  );

  ctx.fill();
};

module.exports = MovingObject;
