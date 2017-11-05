class Game {
  constructor() {
    this.stacks = [[3,2,1],[],[]];
    this.winning_tower = [3,2,1];
  }


  promptMove(cb) {
    console.log(JSON.stringify(this.stacks));
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

  isValidInput(start, end ){
    if (isNaN(start) || isNaN(end)) {
      return false;
    }
    if ( start < 0 || start > 2 || end < 0 || end > 2){
      return false;
    }

    return true;
  }

  isValidMove(start, end) {
    if (this.stacks[start].length < 1){
      return false;
    }
    if (this.stacks[end].length < 1){
      return true;
    }

    if (this.stacks[start][this.stacks[start].length-1] >
    this.stacks[end][this.stacks[end].length-1]  ){
      return false;
    }

    return true;
  }

  move(start,end){
    this.stacks[end].push(this.stacks[start].pop());
  }

  over() {
    if (this.stacks[1]===this.winning_tower || this.stacks[2]===this.winning_tower){
      return true;
    }
    return false;
  }
  start(){
    
    while(this.over()){
      this.promptMove((from, to) => console.log(`from: ${from} to: ${to}`));
      if (!this.isValidInput()){
        console.log("Invalid Input. Try again");
        this.promptMove((from, to) => console.log(`from: ${from} to: ${to}`));
      }
      if (!this.isValidMove()) {
        console.log("Wrong Move! Try Again.");
        this.promptMove((from, to) => console.log(`from: ${from} to: ${to}`));
      }

      this.move(start,end);
    }

    console.log("You Win! Game Over!");
  }
}

const game = new Game;
game.start();
// game.promptMove((from, to) => console.log(`from: ${from} to: ${to}`));
