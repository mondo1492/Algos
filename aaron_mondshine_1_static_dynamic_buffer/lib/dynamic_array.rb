require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(0)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length || index < 0 || @length == 0
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index > @length || index < 0 || @length == 0
    self.resize!
    @store[index] = value

  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == @capacity || @length <= 0
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.resize!
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == @capacity || @length <= 0
    @length.times do |i|
      @store[i] = @store[i + 1]
    end
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    raise "index out of bounds" if @length == @capacity || @length < 0
    idx_tracker = @length
    while idx_tracker >= 0
      @store[idx_tracker + 1] = @store[idx_tracker]
      idx_tracker -= 1
    end
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length


  def check_index(index)
    index > @length - 1 || index < 0
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    if @length == @capacity
      @capacity = @length * 2

      new_arr = StaticArray.new(@capacity)

      @length.times do |i|
        new_arr[i] = @store[i]
      end
      @store = new_arr

    end
  end
end
