class Clock {
  constructor() {
    const date = new Date(Date.now());
    this.hours = date.getHours();
    this.minutes = date.getMinutes();
    this.seconds = date.getSeconds();
    this.printTime();
    this.interval = setInterval(this._tick.bind(this), 1000);
  }

  printTime() {
    const time = `${this.hours}:${this.minutes}:${this.seconds}`;
    console.log(time);
  }

  _tick() {
    this.seconds++;
    if (this.seconds >= 60) {
      this.minutes++;
      this.seconds -= 60;
    }
    if (this.minutes >= 60) {
      this.hours++;
      this.minutes -= 60;
    }
    if (this.hours >= 24) {
      this.hours -= 24;
    }
    this.printTime();
  }

  stop() {
    clearInterval(this.interval);
  }
}

// const clock = new Clock();

/*
addNumbers
*/

const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function addNumbers (sum, numsLeft, completionCallback) {
  if (numsLeft === 0) {

    reader.close();
    return completionCallback(sum);
  }


  reader.question('Enter some number to add', function (res) {
    sum += parseInt(res);
    console.log(`the sum is ${sum}.`);
    addNumbers(sum, numsLeft-1, completionCallback);

  });
}

addNumbers(0, 3, function(sum) {console.log(`Total Sum: ${sum}`);});
