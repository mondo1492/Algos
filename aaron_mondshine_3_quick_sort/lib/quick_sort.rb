class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.empty?
    pivot = array.first
    left = sort1(array.select { |num| num < pivot })
    right = sort1(array.select { |num| num >= pivot })
    left + [pivot] + right
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    return array if length <= 1

    pivot_idx = partition(array, start, length, &prc)

    left_length = pivot_idx - start
    right_length = length - (left_length + 1)
    sort2!(array, start, left_length, &prc)
    sort2!(array, pivot_idx + 1, right_length, &prc)

    array

  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot_idx, pivot = start, array[start]
    working_arr = (start + 1)..(start + length - 1)
    working_arr.each do |idx|
      el = array[idx]
      if prc.call(pivot, el) >= 1
        array[idx] = array[pivot_idx + 1]
        array[pivot_idx + 1] = pivot
        array[pivot_idx] = el
        pivot_idx += 1
      end
    end

    pivot_idx
  end
end
