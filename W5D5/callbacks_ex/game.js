class Game {
  constructor() {
    this.stacks = [[3,2,1],[],[]];
  }

  print() {
    console.log(JSON.stringify(this.stacks));
  }

  promptMove(cb) {
    this.print();
    const readline = require("readline");

    const reader = readline.createInterface({
      input: process.stdin,
      output: process.stdout
    });

    reader.question('Move from/to: (e.g. 0, 2): ', function(res) {
      const from = parseInt(res[0]);
      const to = parseInt(res[res.length - 1]);

      cb(from, to);
    });
  }

  isValidInput(start, end) {
    if (isNaN(start) || isNaN(end)) {
      return false;
    }
    if ( start < 0 || start > 2 || end < 0 || end > 2) {
      return false;
    }
    return true;
  }

  isValidMove(start, end) {
    if (!this.isValidInput(start, end)) {
      return false;
    }
    if (this.stacks[start].length < 1) {
      return false;
    }
    if (this.stacks[end].length < 1) {
      return true;
    }

    if (this.stacks[start][this.stacks[start].length-1] >
    this.stacks[end][this.stacks[end].length-1]  ){
      return false;
    }

    return true;
  }

  move(start,end) {
    if (this.isValidMove(start, end)) {
      this.stacks[end].push(this.stacks[start].pop());
      return true;
    }
    return false;
  }

  isWon() {
    return (this.stacks[1].length === 3 || this.stacks[2].length === 3);
  }

  run(completionCallback) {
    this.promptMove((from, to) => {
      if (!this.move(from, to)) {
        console.log('Invalid Move.');
      }

      if (this.isWon()) {
        console.log("You Win! Game Over!");
        completionCallback();
      } else {
        this.run(completionCallback);
      }
    });
  }
}

const game = new Game;
game.run();
// game.promptMove((from, to) => console.log(`from: ${from} to: ${to}`));
