class MyStack
  def initialize
    @store = []
  end

  def push(el)
    @store.push(el)
  end

  def pop
    @store.pop
  end

  def last
    @store.last
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
