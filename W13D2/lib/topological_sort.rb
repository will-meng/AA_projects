require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort1(vertices)
  sorted = []
  queue = []
  (vertices.length - 1).downto(0) do |i|
    if vertices[i].in_edges.empty?
      queue.unshift(vertices[i])
      vertices.delete_at(i)
    end
  end
  
  until queue.empty?
    vertex = queue.pop
    sorted << vertex
    (vertex.out_edges.length - 1).downto(0) do |i|
      edge = vertex.out_edges[i]
      to_vertex = edge.to_vertex
      if to_vertex.in_edges.length == 1
        # this is the only in-edge and it should be added to queue
        queue.unshift(to_vertex)
        vertices.delete(to_vertex)
      end
      edge.destroy! 
    end
  end

  if vertices.empty?
    sorted
  else
    # there must be a cycle
    []
  end
end

def topological_sort2(vertices)
  sorted = []
  queue = []
  vertices.each do |vertex|
    queue.unshift(vertex) if vertex.in_edges.empty?
  end
  
  until queue.empty?
    vertex = queue.pop
    sorted << vertex

    out_edges = vertex.out_edges.dup # iterate over copies
    out_edges.each do |edge|
      to_vertex = edge.to_vertex
      if to_vertex.in_edges.length == 1
        # this is the only in-edge and it should be added to queue
        queue.unshift(to_vertex)
      end
      edge.destroy! # this destroys the "real" edge and not the dupe
    end
  end

  vertices.length == sorted.length ? sorted : []
end

def topological_sort(vertices, idx = 0)
  ordering = {} # keys are vertices, values are order #
  visited = {} # keys are vertices, value is true if already visited

  vertices.each do |vertex|
    cyclic = visit_dependents(vertex, ordering, visited) 
    return [] if cyclic
  end

  if ordering.keys.length == vertices.length 
    ordering.sort_by { |k, v| -v } # smallest number should be last
            .map { |kv_pair| kv_pair.first }
  else
    []
  end
end

def visit_dependents(vertex, ordering, visited) 
  return false if ordering[vertex]
  # note visited is never checked if ordering contains vertex, which happens on way back
  # thus visited is tracking only if a code is visited twice on the way "out"
  return true if visited[vertex]
  visited[vertex] = true

  vertex.out_edges.each do |out_edge|
    cyclic = visit_dependents(out_edge.to_vertex, ordering, visited)
    return true if cyclic
  end
  
  ordering[vertex] = ordering.keys.length
  false
end