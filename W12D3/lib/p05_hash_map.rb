require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    # include?(key) ? bucket(key).update(key, val) : bucket(key).append(key, val)

    # overwrite if key already exists
    bucket(key).each do |node|
      if node.key == key
        node.val = val
        return val
      end
    end

    # append if key does not exist
    resize! if count == num_buckets
    @count += 1
    bucket(key).append(key, val)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    remove = bucket(key).remove(key)
    @count -= 1 if remove
    remove
  end

  def each
    @store.each do |bucket|
      bucket.each { |node| yield(node.key, node.val) }
    end
    self
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    old_store.each do |bucket|
      bucket.each { |node| bucket(node.key).append(node.key, node.val) }
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
