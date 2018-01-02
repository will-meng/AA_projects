require_relative "static_array"

class RingBuffer
  attr_reader :length
  STARTING_CAPACITY = 8

  def initialize
    @store = StaticArray.new(STARTING_CAPACITY)
    @capacity = STARTING_CAPACITY
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    if check_index(index)
      store[(start_idx + index) % capacity]
    else
      raise 'index out of bounds'
    end
  end

  # O(1)
  def []=(index, val)
    if check_index(index)
      store[(start_idx + index) % capacity] = val
    else
      raise 'index out of bounds'
    end
  end

  # O(1)
  def pop
    raise 'index out of bounds' if length == 0
    @length -= 1
    store[(start_idx + length) % capacity]
  end

  # O(1) ammortized
  def push(val)
    resize! if length == capacity
    store[(start_idx + length) % capacity] = val
    @length += 1
    store
  end

  # O(1)
  def shift
    raise 'index out of bounds' if length == 0
    shifted_el = store[start_idx]
    @start_idx = (start_idx + 1) % capacity
    @length -= 1
    shifted_el
  end

  # O(1) ammortized
  def unshift(val)
    resize! if length == capacity
    @start_idx = start_idx == 0 ? capacity - 1 : start_idx - 1
    store[start_idx] = val
    @length += 1
    store
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    index >= 0 && index < length
  end

  def resize!
    new_store = StaticArray.new(capacity * 2)
    length.times { |i| new_store[i] = store[(start_idx + i) % capacity] }
    @capacity *= 2
    @start_idx = 0
    @store = new_store  
  end
end
