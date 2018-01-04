require_relative "heap"

class Array
  def heap_sort!
    prc = proc { |el1, el2| el2 <=> el1 }

    2.upto(length) do |i|
      BinaryMinHeap.heapify_up(self, i - 1, i, &prc)
    end

    (length - 1).downto(1) do |i|
      self[0], self[i] = self[i], self[0]
      BinaryMinHeap.heapify_down(self, 0, i, &prc)
    end
  end
end
