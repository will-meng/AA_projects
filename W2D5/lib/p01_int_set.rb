class MaxIntSet
  def initialize(max)
    @store = Array.new(max+1)
    @max = max
  end

  def insert(num)
    if !is_valid?(num)
      raise "Out of bounds"
    end
    if @store[num]
      return false
    end
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return if include?(num)
    self[num].push(num)
  end

  def remove(num)
    self[num].each_with_index do |n, i|
      self[num].delete_at(i) if n == num
    end
  end

  def include?(num)
    self[num].each { |n| return true if n == num }
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
    return if include?(num)
    resize! if @count == num_buckets
    self[num].push(num)
    @count += 1
  end

  def remove(num)
    self[num].each_with_index do |n, i|
      self[num].delete_at(i) if n == num
    end
  end

  def include?(num)
    self[num].each { |n| return true if n == num }
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

  def resize!
    new_bucket_length = num_buckets * 2
    new_resizing = Array.new(new_bucket_length) { Array.new }
    @store.each do |bucket|
      bucket.each do |val|
        new_resizing[val % new_bucket_length].push(val)
      end
    end
    @store = new_resizing
  end
end
