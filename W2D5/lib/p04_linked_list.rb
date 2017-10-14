class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
    @val
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    self.each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    curr = first
    until curr.next == nil
      return curr.val if curr.key == key
      curr = curr.next
    end
    nil
  end

  def include?(key)
    curr = first
    until curr.next == nil
      return true if curr.key == key
      curr = curr.next
    end
    false
  end

  def append(key, val)
    if !include?(key)
      node = Node.new(key, val)
      node.next = @tail
      node.prev = @tail.prev
      @tail.prev = node
      node.prev.next = node
    end
  end

  def update(key, val)
    curr = first
    until curr.next == nil
      if curr.key == key
        curr.val = val
        break
      end
      curr = curr.next
    end
  end

  def remove(key)
    curr = first
    until curr.next == nil
      if curr.key == key
        return curr.remove
      end
      curr = curr.next
    end
    false
  end

  def each(&prc)
    #init to head
    curr = first
    until curr.next == nil
      prc.call(curr)
      curr = curr.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
