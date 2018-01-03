require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    node = @map[key] # check if key already exists
    node ? update_node!(node) : calc!(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    node = @store.append(key, @prc.call(key)) # add to store
    @map[key] = node # add to map
    eject! if count > @max
    node.val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove # remove self from linked list
    @map[node.key] = @store.append(node.key, node.val) # add self back to end of linked list
    node.val
  end

  def eject!
    oldest_node = @store.first
    oldest_node.remove # remove from store
    @map.delete(oldest_node.key) # remove from map
  end
end
