require_relative 'stackqueue'

def windowed_max_range(arr, w)
  max = 0

  arr.each_cons(w) do |subarr|
    max_range = subarr.max - subarr.min
    max = max_range if max_range > max
  end

  max
end

# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

def windowed_max_range2(arr, w)
  max = 0
  stack_queue = MinMaxStackQueue.new(w)

  0.upto(arr.length - 1) do |i|
    stack_queue.enqueue(arr[i])
    max_range = stack_queue.max - stack_queue.min
    max = max_range if max_range > max
  end

  max
end

p windowed_max_range2([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range2([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range2([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range2([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
