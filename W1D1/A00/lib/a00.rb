# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

# def caesar_cipher(str, shift)
#   alphabet = ("a".."z").to_a
#   encoded_str = ''
#   str.each_char do |ch|
#     if alphabet.include?(ch)
#       cur_idx = alphabet.index(ch)
#       new_idx = (cur_idx + shift) % 26
#       encoded_str << alphabet[new_idx]
#     else
#       encoded_str << ch
#     end
#   end
#   encoded_str
# end

def caesar_cipher(str, shift)
  base = 'a'.ord
  shifted_arr = str.bytes.map do |n|
    n.chr == ' ' ? n : (n - base + shift) % 26 + base
  end
  shifted_arr.map!(&:chr).join('')
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

# Example:
# digital_root(4322) => 2
# (4 + 3 + 2 + 2) => 11 => (1 + 1) => 2

# def digital_root(num)
#   result = digital_root_step(num)
#   until result / 10 == 0
#     result = digital_root_step(result)
#   end
#   result
# end

def digital_root(num)
  result = digital_root_step(num)
  return result if result / 10 == 0
  digital_root_step(result)
end

# def digital_root_step(num)
#   sum = 0
#   leftover = num
#   until leftover == 0
#     digit = leftover % 10
#     leftover /= 10
#     sum += digit
#   end
#   sum
# end

def digital_root_step(num)
  return num if num / 10 == 0
  num % 10 + digital_root_step(num / 10)
end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  alphabet ||= ('a'..'z').to_a.select { |ch| str.include?(ch) }
  alphabet.map { |ch| ch * str.count(ch) }.join('')
end

# def jumble_sort(str, alphabet = nil)
#   alphabet ||= ('a'..'z').to_a
#   position_hash = {}
#   str.each_char do |ch|
#     position_hash[ch] = alphabet.index(ch)
#   end
#   new_str = ''
#   sorted_arr = position_hash.sort_by { |k, v| v}
#   sorted_arr.each do |pair|
#     new_str += pair.first * str.count(pair.first)
#   end
#   new_str
# end

# def jumble_sort(str, alphabet = nil)
#   alphabet ||= ('a'..'z').to_a
#   sorted = false
#   new_str = str.dup
#   until sorted
#     sorted = true
#     0.upto(str.length - 2) do |i|
#       if alphabet.index(new_str[i]) > alphabet.index(new_str[i + 1])
#         new_str[i], new_str[i + 1] = new_str[i + 1], new_str[i]
#         sorted = false
#       end
#     end
#   end
#   new_str
# end

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

#   def two_sum
#     result = []
#     i = 0
#     while i < self.length - 1
#       j = i + 1
#       while j < self.length
#         result << [i, j] if self[i] + self[j] == 0
#         j += 1
#       end
#       i += 1
#     end
#     result
#   end
# end

  def two_sum
    result = []
    0.upto(length - 2) do |i|
      (i + 1).upto(length - 1) do |j|
        result << [i, j] if self[i] + self[j] == 0
      end
    end
    result
  end
end

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    result = []
    self.length.downto(1) do |len|
      self.chars.each_cons(len) do |arr|
        substring = arr.join('')
        result << substring if dictionary.include?(substring)
      end
    end
    result.uniq
  end
end

# Write a method that returns the factors of a number in ascending order.

# def factors(num)
#   result = []
#   1.upto(num) do |n|
#     result << n if num % n == 0
#   end
#   result.sort
# end

def factors(num)
  (1..num).select { |n| num % n == 0 }
end
