require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  # a palindrome can be made if 
  # a) letter count is odd and only 1 letter has an odd count
  # b) letter count is even and no letter has an odd count
  counts = HashMap.new(string.length)
  string.chars.each do |ch| # O(n) iteration over each letter
    letter_count = counts[ch] # O(1) avg lookup time
    counts[ch] = letter_count ? letter_count + 1 : 1 # O(1) avg insertion time
  end
  
  odd_count = 0
  counts.each do |ch, count| # O(1) iteration since at most 26 letters
    return false if string.length.even? && count.odd?
    odd_count += 1 if count.odd?
    return false if odd_count > 1
  end

  true
end
