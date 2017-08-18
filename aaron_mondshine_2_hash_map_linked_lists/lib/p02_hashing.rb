class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum_hash = 0
    self.each_with_index do |el, i|
      sum_hash += (el.hash*i.hash)
    end
    sum_hash
  end
end

class String
  def hash
    sum_hash = 0
    self.chars.each_with_index do |el, i|
      sum_hash += (el.ord+i).hash
    end
    sum_hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum_hash_key = 0
    sum_hash_val = 0
    self.each do |key, val|
      sum_hash_key += key.hash
      sum_hash_val += val.hash
    end
    sum_hash_key + sum_hash_val
  end
end
