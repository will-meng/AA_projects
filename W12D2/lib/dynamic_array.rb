require_relative "static_array"

class DynamicArray
  attr_reader :length
  STARTING_CAPACITY = 8

  def initialize
    @store = StaticArray.new(STARTING_CAPACITY)
    @capacity = STARTING_CAPACITY
    @length = 0
  end

  # O(1)
  def [](index)
    check_index(index) ? store[index] : (raise 'index out of bounds')
  end

  # O(1)
  def []=(index, value)
    check_index(index) ? store[index] = value : (raise 'index out of bounds')
  end

  # O(1)
  def pop
    raise 'index out of bounds' if length == 0
    @length -= 1
    store[length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length == capacity
    store[length] = val
    @length += 1
    store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if length == 0
    first_el = store[0]
    1.upto(length) { |i| store[i - 1] = store[i] }
    @length -= 1
    first_el
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == capacity
    (length - 1).downto(0) { |i| store[i + 1] = store[i] }
    store[0] = val
    @length += 1
    store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    index >= 0 && index < length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(capacity)
    length.times { |i| new_store[i] = store[i] }
    @store = new_store
  end
end
