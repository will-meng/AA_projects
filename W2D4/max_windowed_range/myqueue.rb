class MyQueue
  def initialize
    @store = []
  end

  def enqueue(el)
    @store.unshift(el)
  end

  def dequeue
    @store.pop
  end

  def peek
    print "#{@store}\n"
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end
