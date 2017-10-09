class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    node.children << self unless node.nil?
  end

  def children
    @children
  end

  def value
    @value
  end

  def add_child(node)
    node.parent = self
  end

  def remove_child(node)
    if @children.include?(node)
      node.parent = nil
    else
      raise "#{self.value} is not a parent of #{node.value}"
    end
  end

  def dfs(target_value)
    return self if self.value == target_value

    children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    return self if self.value == target_value
    queue = []
    queue.concat(children)

    until queue.empty?
      next_node = queue.shift
      return next_node if next_node.value == target_value
      queue.concat(next_node.children) unless next_node.children.empty?
    end
    # queue.each do |node|            ---Fun experiment---
    #   return node if node.value == target_value
    #   queue.concat(node.children) if node.children
    # end

    nil
  end

end
