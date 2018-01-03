class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length - 1)
  end

  def validate!(num)
    raise 'Out of bounds' unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return false if include?(num)
    self[num].push(num)
    num
  end

  def remove(num)
    # self[num].delete(num)
    bucket = self[num]
    found = false
    (0...bucket.length).each do |i|
      bucket[i - 1] = bucket[i] if found
      if bucket[i] == num
        found = true
        bucket.pop if i == bucket.length - 1
      end
    end
    found ? num : false
  end

  def include?(num)
    # self[num].include?(num)
    bucket = self[num]
    (0...bucket.length).each do |i| 
      return true if bucket[i] == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == num_buckets
    return false if include?(num)
    @count += 1
    self[num].push(num)
  end

  def remove(num)
    bucket = self[num]
    found = false
    (0...bucket.length).each do |i|
      bucket[i - 1] = bucket[i] if found #shift all subsequent elements
      if bucket[i] == num
        found = true
        bucket.pop if i == bucket.length - 1
        @count -= 1
      end
    end
    found ? num : false
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each { |num| new_store[num % (num_buckets * 2)].push(num) }
    end
    @store = new_store
  end
end
