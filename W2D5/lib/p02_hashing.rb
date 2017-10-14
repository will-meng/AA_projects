class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.join.to_i.hash
  end
end

class String
  def hash
    self.bytes.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    pre_hash = ''
    self.sort_by { |k, v| k }.each do |pair|
      pre_hash += pair[0].to_s + pair[1].to_s
    end
    pre_hash.hash
  end
end
