require_relative 'graph'
require 'set'
# Implementing topological sort using both Khan's and Tarian's algorithms

# Kahn's using #destroy!
# def topological_sort(vertices)
#   sorted = []
#   q = []
#
#   vertices.each do |vertex|
#     q.push(vertex) if vertex.in_edges.empty?
#   end
#
#   until q.empty?
#     curr = q.shift
#     sorted << curr
#     edges = curr.out_edges.dup
#     edges.each do |edge|
#       if edge.to_vertex.in_edges.count <= 1
#         q.push(edge.to_vertex)
#       end
#       edge.destroy!
#     end
#   end
#
#   vertices.length == sorted.length ? sorted : []
# end
#
#
# Kahn's
# O(|V| + |E|).
# def topological_sort(vertices)
#   queue = []
#   in_edges = {}
#   order = []
#
#   vertices.each do |vert|
#     in_edge_count = vert.in_edges.reduce(0){ |accum, edge| accum += edge.cost }
#     in_edges[vert] = in_edge_count
#     queue << vert if in_edge_count == 0
#   end
#
#   count = 0
#   cyclic = false
#
#   until cyclic || queue.empty?
#     count += 1
#     cyclic = (count == vertices.length + 1)
#
#     vertex = queue.shift
#
#     vertex.out_edges.each do |edge|
#       new_vertex = edge.to_vertex
#       in_edges[new_vertex] -= edge.cost
#       queue << new_vertex if in_edges[new_vertex] == 0
#     end
#
#     order << vertex
#   end
#   unconnected = count <= vertices.length - 1
#   ( cyclic || unconnected ) ? [] : order
# end

# # Tarjan's
# def topological_sort(vertices)
#   ordering = []
#   explored = Set.new
#
#   vertices.each do |vertex| # O(|v|)
#     dfs!(vertex, explored, ordering) unless explored.include?(vertex)
#   end
#
#   ordering
# end
#
# def dfs!(vertex, explored, ordering)
#   explored.add(vertex)
#
#   vertex.out_edges.each do |edge| # O(|e|)
#     new_vertex = edge.to_vertex
#     dfs!(new_vertex, explored, ordering) unless explored.include?(new_vertex)
#   end
#
#   ordering.unshift(vertex)
# end

# # Tarjans with cycle catching
# def topological_sort(vertices)
#   order = []
#   explored = Set.new
#   temp = Set.new
#   cycle = false
#
#   vertices.each do |vertex|
#     cycle = dfs!(vertex, explored, temp, order, cycle)  unless explored.include?(vertex)
#     return [] if cycle
#   end
#
#   order
# end
#
#
# def dfs!(vertex, explored, temp, order, cycle)
#   return true if temp.include?(vertex)
#   temp.add(vertex)
#
#   vertex.out_edges.each do |edge|
#     next_vertex = edge.to_vertex
#     cycle = dfs!(next_vertex, explored, temp, order, cycle) unless explored.include?(next_vertex)
#     return true if cycle
#   end
#
#   explored.add(vertex)
#   temp.delete(vertex)
#   order.unshift(vertex)
#   false
# end
