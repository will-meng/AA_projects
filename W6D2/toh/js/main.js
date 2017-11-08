const HanoiGame = require('./game');
const HanoiView = require('./hanoi-view.js');

$( () => {
  const $rootEl = $('.hanoi');
  const game = new HanoiGame();
  new HanoiView(game, $rootEl);
});
