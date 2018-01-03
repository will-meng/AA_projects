- Specify which aspect (or aspects) of the input the time complexity depends on. E.g., if a function is O(n), what is n?
- Explain thoroughly and clearly why the time complexity is what it is.
- Find the worst cases.
- Discuss space complexity too (this is usually deemphasized over time complexity)

1.
def add(a, b)
  if a > b
    return a + b
  end

  a - b
end

O(1) because there are exactly 2 operations (1 for comparison, 1 for addition/subtraction) each time the method is called, regardless of the magnitude of a or b.

2.
def print_arr_1(arr)
  arr.each do |idx|
    puts el
  end
end

O(n) since there are exactly n print statements, where n is the number of elements in the input array.

3.
def print_arr_2(arr)
  arr.each_with_index do |el, idx|
    break if idx == arr.length/2 - 1
    puts el
  end
end

O(n) because there are slightly less than n / 2 comparison and print operations before the loop breaks. n is the number of array elements.

4.
def print_arr_3(arr)
  arr.each do |el|
    break if el == arr.length/2 - 1
    puts el
  end
end

O(n) because in the worst case, none of the elements equals arr.length / 2 - 1, so every element is printed. In the best case, the first element would break out of the loop and it would be O(1). n is the number of array elements.

5.
def print_arr_4(arr)
  arr.each do |el|
    break if el == arr.length/2 - 1
    puts el
  end

  arr.each_with_index do |el, idx|
    puts el if idx % 3 == 0
  end

  puts arr.last
end

O(n) even though there is an additional each_with_index loop, because the two loops have additive time complexity due to not being nested. The second loop will have n comparison operations and n / 3 print operations. n is the number of array elements.

6.
def search(arr, target)
  arr.each_with_index do |el, idx|
    return idx if el == target
  end
end

O(n) because in the worst case, none of the elements is equal to the target, so n comparison operations are made. n is the number of array elements.

7.
def searchity_search(arr, target)
  results = []
  arr.each do |el|
    results << search(arr, target + el)
  end

  results  
end

O(n^2) because in the worst case, search never finds the target and iterates over the entire array each time. This is done n times in searchity_search, so at worst there would be n * n = n^2 operations. n is the number of array elements. Space complexity is O(n) since the results array will have n elements.

8.
def searchity_search_2(arr, target)
  results = []
  arr.each do |el|
    results << search(arr, el)
  end

  results  
end

O(n^2) although there is no variance here. Search will always find the target, since it is always one of the elements in the array. There will still be n calls to search, but the number of operations in each call is known: 1, 2, …, n. The sum of 1, 2, …, n is n * (n + 1) / 2, which is still on the order of n^2 (though faster than the original searchity_search). n is the number of array elements. Space complexity is O(n) since the results array will have n elements.

9.
let iterative_1 = (n, m) => {
  let notes = ["do", "rei", "mi", "fa", "so", "la", "ti", "do"];

  for (var i = 0; i < n; i++) {
    for (var j = 0; j < m; j++) {
      let position = (i+j) % 8;
      console.log(notes[position]);
    }
  }
}

O(n * m) since there are a constant number of operation inside of the double loop, and the loops have n and m iterations, respectively.

10.
let iterative_2 = (n) => {
  let notes = ["do", "rei", "mi", "fa", "so", "la", "ti", "do"];

  for (var i = 0; i < n; i++) {
    for (var j = i; j >= 0; j--) {
      let position = (i+j) % 8;
      console.log(notes[position]);
    }
  }
}

O(n^2) since the outer loop still has n iterations, but the inner loop now varies from 1 to n iterations. Thus, there are n * (n + 1) / 2 total loop iterations with a constant number of operations in each, so overall the time complexity is still on the order of n^2.

11.
let iterative_3 = (n, m) => {
  let notes = ["do", "rei", "mi", "fa", "so", "la", "ti", "do"];

  let bigger = n > m ? n : m;
  let smaller = n <= m ? n : m;

  for (var i = 0; i < smaller; i++) {
    for (var j = i; j < bigger; j++) {
      let position = (i+j) % 8;
      console.log(notes[position]);
    }
  }
}

O(n^2) since the number of inner loop iterations varies from n when i == 0 (assume n is “bigger”) to n - m when i == m - 1. The sum of n - m, n - m + 1, n - m + 2, …, n is ((n - m) + n ) * m / 2, which simplifies to n * m - m^2 / 2. The worst case occurs as m approaches n, as the expression simplifies to n^2 / 2. The best case occurs when m approaches 1 (assuming that is the lower bound of m and n), in which case the expression reduces to n - ½, which is O(n).

12.
def rec_mystery(n)
  return n if n < 5

  rec_mystery(n - 5)
end

O(n) because there will be approximately n / 5 recursive calls when n > 4, and each call has 1 comparison operation.

13.
def rec_mystery_2(n)
  return 0 if n == 0

  rec_mystery_2(n/5) + 1
end

O(log n) assuming n >= 0 since the recursive stacks end when n < 5, and the input is divided by 5 each recursive call. If n < 0, there will be a stack overflow.

14.
void rec_mystery_3(int n, int m, int o)
{
  if (n <= 0)
  {
    printf("%d, %d\n", m, o);
  }
  else
  {
    rec_mystery_3(n-1, m+1, o);
    rec_mystery_3(n-1, m, o+1);
  }
}

O(2^n) because there are 2 recursive calls in the body of the function, and the recursion should end after n inductive steps.

15.
class Array
  def grab_bag
    return [[]] if empty?
    bag = take(count - 1).grab_bag
    bag.concat(bag.map { |handful| handful + [last] })
  end
end

O(n^2) because each map performs n concatenations, and there are n recursive calls. So this becomes another 1 + 2 + … + n type of method, which reduces to the order of n^2. 
