def range(start, range_end)
  return [] if start >= range_end
  range(start + 1, range_end).unshift(start)
end
# p range(2, 6)

def exp(base, power)
  return 1 if power == 0
  if power < 0
    (1.0 / base) * exp(base, power + 1)
  else
    base * exp(base, power - 1)
  end
end

def exp2(base, power)
  return 1 if power.zero?
  smaller_exp = exp2(base, power / 2)
  if power.even?
    smaller_exp * smaller_exp
  else
    base * smaller_exp * smaller_exp
  end
end
# p exp2(2, 4)

def deep_dup(arr)
  arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el }
end

def fibonacci(n)
  return nil if n < 1
  return [1] if n == 1
  return [1, 1] if n == 2

  previous = fibonacci(n - 1)
  current = previous.last + previous[-2]
  previous << current
end
# p fibonacci(7)

def subsets(arr)
  return [[]] if arr.empty?
  last_el = arr.pop
  smaller_subsets = subsets(arr)
  right = smaller_subsets.map { |el| el + [last_el] }
  smaller_subsets + right
end
# p subsets([1, 2, 3])

def permutations(arr)
  return [arr] if arr.length <= 1
  result = []
  arr.each_with_index do |num, i|
    permutations(arr.take(i) + arr.drop(i + 1)).each do |s_arr|
      result << [num] + s_arr
    end
  end
  result
end
# p permutations([1, 2, 3])

def bsearch(arr, target)
  return nil if arr.empty?

  mid_idx = arr.length / 2
  if target > arr[mid_idx]
    right_idx = bsearch(arr[mid_idx..-1], target)
    right_idx.nil? ? nil : mid_idx + right_idx
  elsif target < arr[mid_idx]
    left_idx = bsearch(arr[0...mid_idx], target)
    left_idx.nil? ? nil : left_idx
  else
    mid_idx
  end
end
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil

def merge_sort(arr)
  return arr if arr.length <= 1

  midx = arr.length / 2
  merge_and_sort(merge_sort(arr.take(midx)), merge_sort(arr.drop(midx)))
end

def merge_and_sort(left, right)
  merged = []

  until left.length.zero? && right.length.zero?
    if left.empty?
      merged << right.shift
    elsif right.empty?
      merged << left.shift
    elsif left.first > right.first
      merged << right.shift
    else
      merged << left.shift
    end
  end

  merged
end
# p merge_sort([20, 3, 7, 49, 21, 16, 96, 6])

def greedy_make_change(target, coins)
  return nil if coins.empty?

  coins = coins.sort.reverse
  big_coin = coins.shift

  leftover = target
  count = 0
  until leftover < big_coin
    leftover -= big_coin
    count += 1
  end
  return Array.new(count, big_coin) if leftover.zero?

  sub_problem = greedy_make_change(leftover, coins)
  sub_problem.nil? ? nil : Array.new(count, big_coin) + sub_problem
end
# p greedy_make_change(14, [10, 7, 1])

def better_make_change(target, coins)
  results = []
  coins.each_with_index do |coin, i|
    leftover = target - coin
    next if leftover < 0
    return [coin] if leftover.zero?
    sub_problem = better_make_change(leftover, coins.drop(i))
    return nil if sub_problem.nil?
    results << [coin] + sub_problem
  end
  return nil if results.empty?

  best = results.first
  results.each { |result| best = result if result.length < best.length }
  best
end
# p better_make_change(14, [10, 7, 1])
