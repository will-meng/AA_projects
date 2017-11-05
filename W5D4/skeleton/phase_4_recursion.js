function range(start, end) {
  if (end < start || arguments.length < 2) {
    return [];
  }
  if (start === end) {
    return [end];
  }
  return [start].concat(range(start + 1, end));
}

function sumRec(arr) {
  if (arr.length < 1) {
    return 0;
  }
  if (arr.length === 1) {
    return arr[0];
  }

  return arr[0] + sumRec(arr.slice(1));
}

const exponent = function(base, exp) {
  if (exp === 0) {
    return 1;
  }

  return base * exponent(base, exp - 1);
};

const exponent2 = function(base, exp) {
  if (exp === 0) {
    return 1;
  }

  const recursiveCall = exponent2(base, Math.floor(exp / 2));
  if (exp % 2 === 0) {
    return recursiveCall * recursiveCall;
  } else {
    return base * recursiveCall * recursiveCall;
  }
};

const fibonacci = function(n) {
  if (n === 1) return [1];
  if (n === 2) return [1, 1];

  const prev = fibonacci(n - 1);
  const i = prev.length;
  prev.push(prev[i - 1] + prev[i - 2]);
  return prev;
};

const bsearch = function(arr, target, start = 0, end = arr.length - 1) {
  if (start > end) {
    return -1;
  }

  const mid = Math.floor((start + end) / 2);
  if (arr[mid] === target) {
    return mid;
  } else if (arr[mid] < target) {
    return bsearch(arr, target, mid + 1, end);
  } else {
    return bsearch(arr, target, start, mid - 1);
  }
};

const mergesort = function(arr) {
  if (arr.length <= 1) {
    return arr;
  }

  const mid = Math.floor(arr.length / 2);
  const left = mergesort(arr.slice(0, mid));
  const right = mergesort(arr.slice(mid));

  const merged = [];
  while (left.length > 0 && right.length > 0) {
    if (left[0] > right[0]){
      merged.push(right.shift());
    } else {
      merged.push(left.shift());
    }
  }

  return merged.concat(left).concat(right);
};

const subsets = function(arr) {
  if (arr.length === 1) {
    return [[], arr];
  }
  const l = arr.length - 1;
  const smaller = subsets(arr.slice(0, l));
  const right = [];
  smaller.forEach(function(subArr) {
    right.push(subArr.concat([arr[l]]));
  });

  return smaller.concat(right);
};
