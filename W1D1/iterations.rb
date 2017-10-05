def factors(num)
  (1..num).select { |x| num % x == 0 }
end

class Array
  def bubble_sort!
    sorted = false
    until sorted
      sorted = true
      (0..self.length - 2).each do |idx|
        if self[idx] > self[idx + 1]
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
      end
    end
    self
  end

  def bubble_sort!(&prc)
    sorted = false
    until sorted
      sorted = true
      (0..self.length - 2).each do |idx|
        if prc.call(self[idx], self[idx + 1]) == 1
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
      end
    end
    self
  end

  # def bubble_sort
  #   self.dup.bubble_sort!
  # end

end

def substrings(string)
  result = []
  i = 0
  while i < string.length
    length = 1;
    while i + length <= string.length
      substring = string.slice(i, length)
      result << substring
      length += 1
    end
    i += 1
  end
  result
end

def substrings(string)
  result = []
  1.upto(string.length) do |length|
    string.chars.each_cons(length) do |arr|
      result << arr.join('')
    end
  end
  result
end

def subwords(word, dictionary)
  substrings(word).select { |str| dictionary.include?(str) }
end
