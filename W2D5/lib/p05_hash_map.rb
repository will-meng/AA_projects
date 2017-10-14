require 'byebug'
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
    if self.include?(key)
      bucket(key).update(key, val)
    else
      if (@count + 1) > num_buckets
        resize!
      end
      bucket(key).append(key, val)
      @count += 1
    end
    val
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    val = bucket(key).remove(key)
    if !val.nil?
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call(node.key, node.val)
      end
    end
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
    new_bucket_length = num_buckets * 2
    new_resizing = Array.new(new_bucket_length) { LinkedList.new }
    @store.each do |list|
      list.each do |node|
        new_resizing[node.key.hash % new_bucket_length].append(node.key, node.val)
      end
    end
    @store = new_resizing
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
