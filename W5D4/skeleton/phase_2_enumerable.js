Array.prototype.myEach = function(cb) {
  for (let i = 0; i < this.length; i++) {
    cb(this[i], i, this);
  }
};

Array.prototype.myMap = function(cb) {
  const result = [];
  this.myEach((el, i, arr) => {
    result.push(cb(el, i, arr));
  });
  return result;
};

Array.prototype.myReduce = function(callback, initialValue) {
  let acc;
  const noAcc = typeof initialValue === 'undefined';
  if (noAcc) {
    acc = this[0];
  } else {
    acc = initialValue;
  }

  this.myEach(function(el, i, arr) {
    if (!(noAcc && i === 0)) {
      acc = callback(acc, el);
    }
  });

  return acc;
};
