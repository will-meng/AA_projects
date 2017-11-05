Array.prototype.bubbleSort = function () {
  const result = this.slice();
  let sorted = false;
  while (!sorted) {
    sorted = true;
    for (let i = 0; i < result.length - 1; i++) {
      if (result[i] > result[i+1]){
        sorted = false;
        const temp = result[i];
        result[i] = result[i + 1];
        result[i + 1] = temp;
      }
    }
  }
  return result;
};

String.prototype.substrings = function() {
  const something = {};
  for (let i = 0; i < this.length; i++) {
    for (let j = i + 1; j < this.length; j++) {
      const substr = this.substring(i, j);
      something[substr] = true;
    }
  }
  return Object.keys(something);
};
