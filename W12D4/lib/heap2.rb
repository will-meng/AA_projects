class MinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || proc { |el1, el2| el1 <=> el2 }
  end

  def peek
    return nil if @store.length == 0
    @store[0]
  end

  def insert(val)
    @store.push(val)
    self.class.heapify_up(@store, @store.length - 1, &prc)
    @store
  end

  def extract
    raise 'heap is empty' if @store.length == 0
    @store[0], @store[-1] = @store[-1], @store[0]
    extracted = @store.pop
    self.class.heapify_down(@store, 0, &prc)
    extracted
  end

  def self.child_indices(parent_index, len)
    children = [parent_index * 2 + 1, parent_index * 2 + 2]
    children.select { |idx| idx < len }
  end

  def self.parent_index(child_index)
    return nil if child_index <= 0
    (child_index - 1) / 2
  end

  def self.heapify_up(array, child_idx, &prc)
    parent_idx = parent_index(child_idx)
    until parent_idx.nil? || prc.call(array[parent_idx], array[child_idx]) < 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx, parent_idx = parent_idx, parent_index(parent_idx)
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    loop do
      children = child_indices(parent_idx, len)
      child_idx = nil

      case children.length
        when 0
          break
        when 1
          child_idx = children[0]
        when 2
          child_idx = prc.call(array[children[0]], array[children[1]]) == -1 ?
            children[0] : children[1]
      end

      if prc.call(array[parent_idx], array[child_idx]) == 1
        array[parent_idx], array[child_idx] = 
          array[child_idx], array[parent_idx]
        parent_idx = child_idx
      else
        break
      end

    end
  end
end

def heapsort(arr)
  # move partition right, max heap on left. heapify up.
  # extract and move partition left
  return arr if arr.length < 2

  prc = proc { |el1, el2| el2 <=> el1 } # create MaxHeap

  1.upto(arr.length - 1) do |child_idx|
    MinHeap.heapify_up(arr, child_idx, &prc)
  end

  (arr.length - 1).downto(1) do |last_idx|
    arr[0], arr[last_idx] = arr[last_idx], arr[0]
    MinHeap.heapify_down(arr, 0, last_idx, &prc)
  end
  
  arr
end

arr = [-1, -1, 2, 2, 2, 4, 5, 10].shuffle
arr = (0..40).to_a.shuffle
p heapsort(arr)