class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_idx = 0
  end

  def [](i)
    return nil unless i.between?(-@count, @count - 1)
    return self[@count + i] if i < 0 # recursive until -1 < i < @count
    @store[(@start_idx + i) % capacity]
  end

  def []=(i, val)
    raise "index #{i} too small for array; minimum: #{-@count}" if i < -@count
    return self[@count + i] = val if i < 0 # recursive until i >= 0
    (i - @count + 1).times { push(nil) } if i >= @count
    @store[(@start_idx + i) % capacity] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    any? { |el| el == val }
  end

  def push(val)
    resize! if @count == capacity
    @store[(@start_idx + count) % capacity] = val
    @count += 1
    self
  end

  def unshift(val)
    resize! if @count == capacity
    # (count - 1).downto(0) do |i|
    #   @store[i + 1] = self[i]
    # end
    # @store[0] = val
    @start_idx = (@start_idx - 1) % capacity
    @store[@start_idx] = val
    @count += 1
    self
  end

  def pop
    return nil if @count.zero?
    el = last
    @count -= 1
    el
  end

  def shift
    return nil if @count.zero?
    el = first
    # 1.upto(@count - 1) do |i|
    #   self[i - 1] = self[i]
    # end
    @start_idx = (@start_idx + 1) % capacity
    @count -= 1
    el
  end

  def first
    return nil if @count.zero?
    @store[@start_idx]
  end

  def last
    return nil if @count.zero?
    @store[(@start_idx + @count - 1) % capacity]
  end

  def each
    count.times { |i| yield(self[i]) }
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless length == other.length
    each_with_index { |el, i| return false unless el == other[i] }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_static = StaticArray.new(@count * 2)
    each_with_index { |el, i| new_static[i] = el }
    @store = new_static
    @start_idx = 0
  end
end
