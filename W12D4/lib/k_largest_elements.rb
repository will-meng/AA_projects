require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new

  array.each do |el| # O(n)
    heap.push(el) # O(log k)
    heap.extract if heap.count > k # O(log k)
  end

  heap.store
end
