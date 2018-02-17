# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  vertices = build_graph(arr)
  topological_sort(vertices).map { |vertex| vertex.value }

end

def build_graph(arr)
  max_id = arr.flatten.max # O(n)
  vertices = (0..max_id).to_a.map { |id| Vertex.new(id) } # O(n)
  
  arr.each do |id, dependency| # O(n ** 2) in worst case
    Edge.new(vertices[dependency], vertices[id])
  end
  
  vertices
end