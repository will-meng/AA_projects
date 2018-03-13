# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_reader :root

  def initialize
    @root = nil
  end

  # def insert(value, tree_node = @root)
  #   if @root.nil?
  #     @root = BSTNode.new(value)
  #     return
  #   end
    
  #   if value < tree_node.value
  #     tree_node.left ? insert(value, tree_node.left) : tree_node.left = BSTNode.new(value)
  #   else
  #     tree_node.right ? insert(value, tree_node.right) : tree_node.right = BSTNode.new(value)
  #   end
  # end

  def insert(value)
    @root = insert_step(value, @root)
  end

  private
  def insert_step(value, tree_node)
    return BSTNode.new(value) if tree_node.nil?

    if value < tree_node.value
      tree_node.left = insert_step(value, tree_node.left)
    else
      tree_node.right = insert_step(value, tree_node.right)
    end

    tree_node
  end
  public

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if tree_node.value == value

    value < tree_node.value ? find(value, tree_node.left) : find(value, tree_node.right)
  end

  def delete(value)
    delete_from_subtree(value, @root, nil, nil)
  end

  private
  def delete_from_subtree(value, tree_node, parent, dir)
    return nil if tree_node.nil?

    case value <=> tree_node.value
    when 0
      remove_node(tree_node, parent, dir)
      tree_node
    when -1
      delete_from_subtree(value, tree_node.left, tree_node, 'left')
    when 1
      delete_from_subtree(value, tree_node.right, tree_node, 'right')
    end
  end

  def remove_node(tree_node, parent, dir)
    if parent.nil?
      #remove root node
      @root = nil
      return
    end
    
    replacement = if tree_node.left && tree_node.right
      # replace tree_node with maximum from left subtree
      # 1. left_parent_of_max.right = max.left
      # 2. max.left = tree_node.left
      # 3. max.right = tree_node.right
      # 4. parent of tree_node now points to max

      # if tree_node.left has no right child, skip 1-2 above
      if tree_node.left.right
        left_parent_of_max, max_node = maximum_with_left_parent(tree_node)
        left_parent_of_max.right = max_node.left
        max_node.left = tree_node.left
      else
        max_node = tree_node.left
      end

      max_node.right = tree_node.right
      max_node
    elsif tree_node.left
      # single child is replacement node
      tree_node.left
    elsif tree_node.right
      # single child is replacement node
      tree_node.right
    else
      # no children, just remove this node
      nil
    end

    dir == 'left' ? parent.left = replacement : parent.right = replacement
  end

  def maximum_with_left_parent(tree_node)
    # assume tree_node.right exists
    if tree_node.right.right
      maximum_with_left_parent(tree_node.right)
    else
      [tree_node, tree_node.right]
    end
  end

  public
  # helper method for #delete:
  def maximum(tree_node = @root)
    return nil if tree_node.nil?

    tree_node.right ? maximum(tree_node.right) : tree_node
  end

  def depth(tree_node = @root)
  end 

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:

end
