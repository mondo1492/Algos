require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length || index < 0
    @store[(index + self.start_idx) % capacity]

  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" if index >= @length || index < 0
    # self.resize!
    @store[(index + self.start_idx) % capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length <= 0
    popped = self[@length-1]
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    resize!

    @length += 1
    self[@length - 1] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length <= 0
    shifted = self[0]
    self[0] = nil
    @start_idx = (self.start_idx + 1) % capacity
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize!
    @start_idx = (self.start_idx - 1) % capacity
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    if @length == @capacity


      new_arr = StaticArray.new(@capacity *2)

      @length.times do |i|
        new_arr[i] = self[i]
      end
      @store = new_arr
      @start_idx = 0
      @capacity *=2
    end
  end
end
