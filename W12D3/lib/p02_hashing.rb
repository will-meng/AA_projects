class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    join.to_i.hash
    # each_with_index.reduce(0) { |acc, (el, i)| (acc + el % (i + 1)).hash }.hash
  end
end

class String
  def hash
    bytes.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    str = ''
    sort_by { |k, v| k }.each { |pair| str += pair[0].to_s + pair[1].to_s }
    str.hash
  end
end
