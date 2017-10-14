require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if include?(key)
    resize! if @count == num_buckets
    self[key].push(key)
    @count += 1
  end

  def include?(key)
    self[key].each { |n| return true if n == key }
    false
  end

  def remove(key)
    self[key].each_with_index do |n, i|
      self[key].delete_at(i) if n == key
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
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
