# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    (index >= 0 && index < store.length) ? store[index] : (raise 'index out of bounds')
  end

  # O(1)
  def []=(index, value)
    (index >= 0 && index < store.length) ? store[index] = value : (raise 'index out of bounds')
  end

  protected
  attr_accessor :store
end
