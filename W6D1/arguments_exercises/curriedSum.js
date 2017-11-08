const curriedSum = function(numArgs) {
  const numbers = [];
  const _curriedSum = function(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return numbers.reduce(function(acc, el) {
        return acc + el;
      });
    }
    return _curriedSum;
  };
  return _curriedSum;
};

const sum = curriedSum(4);
console.log(sum(5)(30)(20)(1));
//sum(5)(30)(20)(1); // => 56
