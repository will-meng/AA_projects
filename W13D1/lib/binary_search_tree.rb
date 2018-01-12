# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root
      insert_subtree(@root, value)
    else
      @root = BSTNode.new(value)
    end
  end

  def find(value, tree_node = @root)
    return nil unless tree_node
    case value <=> tree_node.value
    when -1
      tree_node.left ? find(value, tree_node.left) : nil
    when 0
      tree_node
    when 1
      tree_node.right ? find(value, tree_node.right) : nil
    end
  end

  def delete(value)
    @root ? delete_subtree(value, @root) : nil
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    tree_node.right ? maximum(tree_node.right) : tree_node
  end

  def maximum_with_parent(tree_node = @root, parent = nil)
    if tree_node.right
      maximum_with_parent(tree_node.right, tree_node)
    else
      [tree_node, parent]
    end
  end

  def depth(tree_node = @root, depth_cache = {})
    return -1 if tree_node.nil?
    return depth_cache[tree_node] if depth_cache[tree_node]

    depth_cache[tree_node] = 1 + [
      depth(tree_node.left, depth_cache), 
      depth(tree_node.right, depth_cache)
    ].max
  end 

  def is_balanced?(tree_node = @root, depth_cache = {})
    return true if tree_node.nil?
    
    diff = (depth(tree_node.left, depth_cache) - 
            depth(tree_node.right, depth_cache)).abs
    is_balanced?(tree_node.left, depth_cache) && 
      is_balanced?(tree_node.right, depth_cache) && 
      diff <= 1
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end


  private
  # optional helper methods go here:
  def insert_subtree(node, value)
    if value < node.value
      node.left ? insert_subtree(node.left, value) : node.left = BSTNode.new(value)
    else
      node.right ? insert_subtree(node.right, value) : node.right = BSTNode.new(value)
    end
  end

  def delete_subtree(value, node, parent = nil)
    case value <=> node.value
    when -1
      node.left ? delete_subtree(value, node.left, node) : nil
    when 0
      remove_node(node, parent)
    when 1
      node.right ? delete_subtree(value, node.right, node) : nil
    end
  end

  def remove_node(node, parent)
    left = node.left
    right = node.right

    replacement =
    if left && right
      # replace node with the maximum of left subtree
      max_node, max_parent = maximum_with_parent(left, node)
      remove_node(max_node, max_parent)
      max_node.left = left
      max_node.right = right
      max_node
    elsif left
      # set left child as parent's new child
      left
    elsif right
      right
    else
      # no children, just delete this node
      nil
    end

    if parent
      parent.left == node ? parent.left = replacement : parent.right = replacement
    else
      # this is the root node, so make the replacement the new root
      @root = replacement
    end

    node
  end
end
