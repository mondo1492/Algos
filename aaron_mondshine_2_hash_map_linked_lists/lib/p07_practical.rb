require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  #construct hashmap that stores val as number of times it comes up
  #if all are 2 % 2 or all but one
  length = string.length
  string_map = HashMap.new(length)
  sum = 0

  string.chars.each do |key|
    if string_map[key]
      string_map[key] = (string_map[key] + 1) % 2
    else
      string_map[key] = 1
    end
  end

  string_map.each do |pair|
    sum += pair[1]
  end
  if length.odd?
    return true if sum == 1
  else
    return true if sum == 0
    false
  end
  false
end
