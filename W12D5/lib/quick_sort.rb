class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = []
    right = []

    1.upto(array.length - 1) do |i|
      array[i] < pivot ? left << array[i] : right << array[i]
    end

    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1

    pivot_idx = partition(array, start, length, &prc)

    # sort the left side
    sort2!(array, start, pivot_idx - start, &prc)

    # sort the right side
    sort2!(array, pivot_idx + 1, start + length - pivot_idx - 1, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    return start if length <= 1
    prc ||= proc { |el1, el2| el1 <=> el2 }

    # random pivot to guard against pathological sets
    # pivot_idx = start + rand(length)

    # move pivot into start position
    # array[start], array[pivot_idx] = array[pivot_idx], array[start]

    # create partition between left and right just to right of start
    part_idx = start + 1

    part_idx.upto(start + length - 1) do |idx|
      if prc.call(array[idx], array[start]) == -1
        # element at idx is less than pivot, swap and move ptr to right
        array[idx], array[part_idx] = array[part_idx], array[idx]
        part_idx += 1
      end
    end

    # swap pivot to left of partition
    pivot_idx = part_idx - 1
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end
end

# arr = (1..20).to_a.shuffle
# p QuickSort.sort1(arr)
[4, 3, 2, 1, 7, 5, 8, 6]
[7,  3, 2, 1, 4, 5, 8, 6]