class Vertex
  attr_accessor :in_edges, :out_edges, :value

  def initialize(value=nil)
    @value = value
    @in_edges = []
    @out_edges = []
  end
end

class Edge
  attr_accessor :cost, :from_vertex, :to_vertex

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    @from_vertex.out_edges.push(self)
    @to_vertex.in_edges.push(self)
    @cost = cost
  end

  def destroy!
    @from_vertex.out_edges.delete(self)
    @to_vertex.in_edges.delete(self)
    @from_vertex = nil
    @to_vertex = nil
  end
end
