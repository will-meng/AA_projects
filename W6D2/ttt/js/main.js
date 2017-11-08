const View = require('./ttt-view');
const Game = require('../node/game');

$( () => {
  const game = new Game();
  const $board = $('.ttt');
  const view = new View(game, $board);
});
