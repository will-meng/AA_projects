const Game = require("./game.js");

const GameView = function(ctx, game) {
  this.game = game;
  this.ctx = ctx;
};

GameView.prototype.start = function () {
  setInterval(() => {
    this.game.moveObjects();
    this.game.draw(this.ctx);
  }, 20);
};

module.exports = GameView;
