# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMaxOld
  attr_accessor :store
  HALF_SIZE = 8 # total size is double this, since there are 2 ring buffers

  def initialize
    @in_stack = RingBuffer.new
    @out_stack = RingBuffer.new
  end

  def enqueue(val)
    transfer if in_stack.length == HALF_SIZE
    fill(in_stack, val)
  end

  def dequeue
    raise 'queue is empty' if length == 0
    transfer if out_stack.length == 0
    out_stack.pop
  end

  def max
    in_max = in_stack.length == 0 ? nil : in_stack[in_stack.length - 1][1]
    out_max = out_stack.length == 0 ? nil : out_stack[out_stack.length - 1][1]

    if in_max
      out_max ? [in_max, out_max].max : in_max
    else
      out_max ? out_max : nil
    end
  end

  def length
    in_stack.length + out_stack.length
  end

  private
  attr_reader :in_stack, :out_stack

  def transfer
    in_stack.length.times { fill(out_stack, in_stack.pop[0]) }
  end

  def fill(array, val)
    # first el is value, second el is max of this array
    el = RingBuffer.new 
    el.push(val)
    el.push(array.length == 0 ? val : [val, array[array.length - 1][1]].max)
    array.push(el)
  end
end

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max_arr = RingBuffer.new
  end

  def enqueue(val)
    add_to_max_arr(val)
    store.push(val)
  end

  def dequeue
    raise 'queue is empty' if length == 0
    val = store.shift
    remove_from_max_arr(val)
    val
  end

  def max
    return nil if length == 0
    max_arr[0]
  end

  def length
    store.length
  end

  private
  attr_reader :max_arr

  def add_to_max_arr(val)
    while max_arr.length > 0 && val > max_arr[max_arr.length - 1]
      max_arr.pop
    end
    
    max_arr.push(val)
  end

  def remove_from_max_arr(val)
    max_arr.shift if val == max_arr[0]
  end
end