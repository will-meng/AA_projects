class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || proc { |el1, el2| el1 <=> el2 }
  end

  def count
    @store.length
  end

  def extract
    raise 'no root node' if count == 0

    store[0], store[count - 1] = store[count - 1], store[0]
    extracted = store.pop
    self.class.heapify_down(store, 0, count, &prc) if count > 0
    extracted
  end

  def peek
    nil if count == 0
    store[0]
  end

  def push(val)
    store.push(val)
    self.class.heapify_up(store, count - 1, count, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    children = [2 * parent_index + 1, 2 * parent_index + 2]
    children.select { |child_idx| child_idx < len }
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    raise 'index out of bounds' unless parent_idx.between?(0, len - 1)
    prc = prc || proc { |el1, el2| el1 <=> el2 }

    loop do
      child_indices = self.child_indices(len, parent_idx)
      break if child_indices.empty?

      child_idx = if child_indices.length == 1
        child_indices[0]
      else
        prc.call(array[child_indices[0]], array[child_indices[1]]) == -1 ?
        child_indices[0] : child_indices[1]
      end

      if prc.call(array[child_idx], array[parent_idx]) == -1
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        parent_idx = child_idx
      else
        break
      end
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    raise 'index out of bounds' unless child_idx.between?(0, len - 1)
    prc = prc || proc { |el1, el2| el1 <=> el2 }
    
    loop do
      break if child_idx == 0
      parent_idx = parent_index(child_idx)
      if prc.call(array[child_idx], array[parent_idx]) == -1
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        child_idx = parent_idx
      else
        break
      end
    end

    array
  end
end
