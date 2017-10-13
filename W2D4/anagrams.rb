require 'benchmark'

def first_anagram?(str1, str2)
  return false unless str1.length == str2.length

  anagrams(str1).include?(str2)
end

def anagrams(str)
  return [str] if str.length <= 1
  perms = []

  str.each_char.with_index do |ch, i|
    substr = anagrams(str[0...i] + str[i + 1..-1])
    substr.each { |sub| perms << (ch + sub)}
  end

  perms
end


def second_anagram?(str1, str2)
  return false unless str1.length == str2.length

  i = 0
  while i < str1.length
    str2.each_char.with_index do |ch2, j|
      if str1[i] == ch2
        str1[i] = ''
        str2[j] = ''
        i -= 1
        break
      end
    end
    i += 1
  end

  str1.empty? && str2.empty?
end


def third_anagram?(str1, str2)
  char_sort(str1) == char_sort(str2)
end

def char_sort(str)
  alphabet = ('a'..'z').to_a
  result = ""
  count = Hash.new(0)

  str.each_char { |ch| count[ch] += 1 }

  alphabet.each do |ch|
    result << ch * count[ch]
  end

  result
end

def fourth_anagram?(str1, str2)
  count = Hash.new(0)
  str1.each_char { |ch| count[ch] += 1 }
  str2.each_char { |ch| count[ch] -= 1 }
  count.values.all? { |n| n == 0 }
end

p fourth_anagram?("kitten", "ittenk")

letters = ('a'..'z').to_a
str1 = letters.shuffle.join
str2 = letters.shuffle.join
str2 = "abclefghijklmnopqrstuvwxyz"

Benchmark.bm do |b|
  # b.report("first") { first_anagram?(str1, str2) }
  b.report("second") { second_anagram?(str1, str2) }
  b.report("third") { third_anagram?(str1, str2) }
  b.report("fourth") { fourth_anagram?(str1, str2) }
end
