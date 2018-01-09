## Almost sorted

# Timestamped data may not always make it into the database in the
# perfect order. Server loads, network routes, etc. Your job is to
# take in a very long sequence of numbers in real-time and efficiently
# print it out in the correct order. Each number is, at most, `k` away
# from its final sorted position. Target time complexity is `O(nlogk)`
# and target space is `O(k)`.

require_relative 'heap'

def almost_sorted(arr, k)
  heap = BinaryMinHeap.new

  k.times { |i| heap.push(arr[i]) } # populate heap with k elements

  k.upto(arr.length - 1) do |i|
    # the minimum of last k elements is extracted and placed k places back in arr
    arr[i - k] = heap.extract 
    heap.push(arr[i])
  end

  k.times { |i| arr[-k + i] = heap.extract  } # populate last k indices of arr

  arr
end

k = 7
arr = (1..k).to_a.shuffle + (k + 1..2 * k).to_a.shuffle + (2 * k + 1..3 * k).to_a.shuffle
p arr
p almost_sorted(arr, k)