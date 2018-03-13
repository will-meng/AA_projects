require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  bst = BinarySearchTree.new
  bst.insert(tree_node)
  sorted = bst.in_order_traversal
  sorted[-k]

  
end
