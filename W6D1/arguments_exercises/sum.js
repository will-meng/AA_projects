const sum = function(...nums) {
  let totalSum = 0;
  nums.forEach(el => {
    totalSum += el;
  });

  return totalSum;
};


console.log(sum(1, 2, 3, 4, 5));
