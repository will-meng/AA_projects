require 'benchmark'

def my_min(list)

  list.length.times do |i|
    smallest = true
    (i + 1...list.length).each do |j|
      if list[i] > list[j]
        smallest = false
        break
      end
    end
    return list[i] if smallest
  end
end

def my_min2(list)
  min = list[0]

  list.drop(1).each do |el|
    min = el if el < min
  end

  min
end

# list = (1..10_000_000).to_a.shuffle

# Benchmark.bm do |b|
#   b.report ("mymin: ") { my_min(list) }
#   b.report ("mymin2: ") { my_min2(list) }
# end

list = [2, 3, -6, 7, -6, 7]

def largest_contiguous_subsum(list)
  subsets = []
  list.each_index do |i|
    (i + 1).upto(list.length - 1) do |j|
      subsets << list[i..j]
    end
  end
  subsets.map { |subset| subset.reduce(:+) }.max
end

p largest_contiguous_subsum(list)

def largest_contiguous_subsum2(list)
  max_sum = list.first
  current_tally = max_sum
  list[1..-1].each do |n|
    # current_tally += n
    # current_tally = n if current_tally < n
    current_tally = current_tally < 0 ? n : current_tally + n
    max_sum = current_tally if current_tally > max_sum
  end
  max_sum
end

p largest_contiguous_subsum2(list)

n = 500
list = (-n..n).to_a.shuffle

Benchmark.bm do |b|
  b.report ("1: ") { largest_contiguous_subsum(list) }
  b.report ("2: ") { largest_contiguous_subsum2(list) }
end
