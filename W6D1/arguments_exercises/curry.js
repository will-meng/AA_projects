Function.prototype.curry = function(numArgs) {
  const params = [];
  const that = this;
  const _curry = function(arg) {
    params.push(arg);
    if(params.length === numArgs) {
      return that.apply(null, params);
    }
    return _curry;
  };
  return _curry;
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

// you'll write `Function#curry`!
let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
console.log(f1 = f1(20)); // [Function]
f1 = f1(6); // = 30

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6));


// const curriedSum = function(numArgs) {
//   const numbers = [];
//   const _curriedSum = function(num) {
//     numbers.push(num);
//     if (numbers.length === numArgs) {
//       return numbers.reduce(function(acc, el) {
//         return acc + el;
//       });
//     }
//     return _curriedSum;
//   };
//   return _curriedSum;
// };
