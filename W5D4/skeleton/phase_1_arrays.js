Array.prototype.uniq = function () {
  const counter = {};
  this.forEach(el => counter[el] = true);

  return Object.keys(counter);
};

Array.prototype.twoSum = function() {
  const result = [];
  for (let i = 0; i < this.length; i++) {
    for (let j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        result.push([i, j]);
      }
    }
  }
  return result;
};

Array.prototype.transpose = function() {
  const l = this[0].length;
  const result = [];
  for (let i = 0; i < l; i++) {
    result.push([]);
  }

  for (let i = 0; i < this.length; i++) {
    for (let j = 0; j < this[i].length; j++) {
      result[j].push(this[i][j]);
    }
  }

  return result;
};
