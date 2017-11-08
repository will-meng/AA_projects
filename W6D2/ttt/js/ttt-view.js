class View {
  constructor(game, $board) {
    this.game = game;
    this.$board = $board;
    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    this.$board.on("click", "li", (event) => {
      const $square = $(event.currentTarget);
      const pos = $square.data('pos');
      const currentPlayer = this.game.currentPlayer;
      this.game.playMove(pos);
      this.makeMove($square, currentPlayer);

    });
  }

  makeMove($square, currentPlayer) {
    $square.text(`${currentPlayer}`);
    $square.addClass("clicked");

    if (this.game.winner()) {
      const winner = this.game.winner();
      const $winMsg = $(`<p>${winner} wins!</p>`);
      this.$board.append($winMsg);
      this.$board.off("click");
      const $squares = $('li');
      $squares.addClass('game-over');
      $squares.each((idx, el) => {
        if (el.textContent === winner) {
          el.classList.add('winner');
        } else {
          el.classList.add('loser');
        }
      });
    }
  }

  setupBoard() {
    const $ul = $("<ul></ul>");
    this.$board.append($ul);

    for (let i = 0; i < 3; i++) {
      for (let j = 0; j < 3; j++) {
        const $square = $("<li></li>");
        $square.data('pos',[i, j]);
        $ul.append($square);
      }
    }

  }
}

module.exports = View;
