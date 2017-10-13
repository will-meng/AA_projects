require 'benchmark'

def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |n, i|
    (i + 1).upto(arr.length - 1) do |j|
      return true if n + arr[j] == target_sum
    end
  end
  false
end

def quicksort(arr, &prc)
  return arr if arr.length <= 1
  prc ||= proc { |n1, n2| n1 <=> n2 }
  idx = rand(arr.length)
  pivot = arr[idx]
  left, right = [], []

  arr[0...idx].each do |n|
    prc.call(n, pivot) == -1 ? left << n : right << n
  end

  arr[idx + 1..-1].each do |n|
    prc.call(n, pivot) == -1 ? left << n : right << n
  end

  quicksort(left, &prc) + [pivot] + quicksort(right, &prc)
end

def binary_search(arr, target, start_idx = 0, end_idx = (arr.length - 1))
  mid = (start_idx + end_idx) / 2

  return mid if arr[mid] == target
  return nil if start_idx >= end_idx
  if arr[mid] > target
    binary_search(arr, target, start_idx, mid - 1)
  else
    binary_search(arr, target, mid + 1, end_idx)
  end
end

def okay_two_sum?(arr, target_sum)
  arr = quicksort(arr)

  (arr.length - 2).times do |i|
    target = target_sum - arr[i]
    return true if binary_search(arr[i + 1..-1], target)
  end
  false
end


def awesome_two_sum?(arr, target_sum)
  count = Hash.new(0)

  arr.each do |n|
    target = target_sum - n
    return true if count.key?(target)
    count[n] += 1
  end

  false
end

arr = (1..10000).to_a.shuffle
target_sum = 0

Benchmark.bm do |b|
  b.report("bad") { bad_two_sum?(arr, target_sum) }
  b.report("okay") { okay_two_sum?(arr, target_sum) }
  b.report("awesome") { awesome_two_sum?(arr, target_sum) }
end
