def range(start, range_end)
  return [] if start == range_end
  [start] + range(start + 1, range_end)
end

def exp(base, power)
  return 1 if power == 0
  if power < 0
    (1.0 / base) * exp(base, power + 1)
  else
    base * exp(base, power - 1)
  end
end

def deep_dup(arr) # [8, [1,2], [3,4], [5,6]]
  #base case:
  return ["hi"] if arr.empty?
  return [arr] unless arr.first.is_a?(Array)
  p "first_dup: #{arr.first}"
  p "range_dup: #{arr[1..-1]}"
  #inductive step:
  # first el of arr, run deep_dup on remaining els
  deep_dup(arr.first) + deep_dup(arr[1..-1])
end

# [8, [1,2], [3,4], [5,6]]
def deep_dup(arr)
  arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el }
end

def fibonacci(n)
  #base:
  return nil if n < 1
  return [1] if n == 1
  return [1, 1] if n == 2

  #inductive:
  previous = fibonacci(n - 1)
  current = previous.last + previous[-2]
  previous + [current]
end

def subsets(arr)
  return [[]] if arr.empty?
  last_el = arr.pop
  smaller_subsets = subsets(arr)
  right = smaller_subsets.map { |el| el + [last_el] }
  smaller_subsets + right
end
# p subsets([1, 2, 3])

def permutations(arr)
  return arr if arr.length == 1
  arr.each_with_index { |num, i| num + permutations(arr[0...i])+ }

end

def bsearch(arr, target)
  return nil if arr.empty?
  midx = arr.length / 2
  if target > arr[midx]
    result = bsearch(arr[midx..-1], target)
    if result.nil?
      nil
    else
      result + midx
    end
  elsif target == arr[midx]
    return midx
  else
    result = bsearch(arr[0...midx], target)
    if result.nil?
      nil
    else
      midx - arr[0...midx].length + result
    end
  end
end


def merge_sort(arr)
  return arr if arr.length == 1
  midx = arr.length / 2

  merge_and_sort(merge_sort(arr[0...midx]), merge_sort(arr[midx..-1]))
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

def greedy_make_change(total, coins)
  big_coin = coins.shift
  change = total
  count = 0
  until change < big_coin
    change -= big_coin
    count += 1
  end

  return Array.new(count, big_coin) if change <= 0

  Array.new(count, big_coin) + greedy_make_change(change, coins)
end
