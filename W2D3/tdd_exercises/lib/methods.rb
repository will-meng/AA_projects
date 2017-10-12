class Array

  def my_uniq
    output = []
    self.each { |el| output << el  unless output.include?(el) }
    output
  end

  def two_sum
    output = []
    self.each_with_index do |el, i|
      (i + 1).upto(length - 1) do |j|
        output << [i, j] if self[i] + self[j] == 0
      end
    end
    output
  end

  def my_transpose
    raise ArgumentError if self == self.flatten

    output = []
    self.length.times { output << [] }
    self.each do |row|
      row.each_with_index { |el, col| output[col] << el }
    end

    output
  end

  def stock_picker
    best = nil
    output = []

    self.each_with_index do |price1, day1|
      (day1 + 1).upto(length - 1) do |day2|

        price_diff = self[day2] - price1

        if best.nil? || price_diff > best
          best = price_diff
          output = [day1, day2]
        end
      end
    end
  output
  end
end

class TowersOfHanoi
  attr_reader :towers

  def initialize(towers = [[3, 2, 1], [], []])
    @towers = towers
  end

  def move
    until won?
      p @towers # best render
      puts "Please choose a start and end tower. (0, 2)"
      input = gets.chomp.split(", ").map(&:to_i)
      p input
      start_tower = input[0]
      end_tower = input[1]
      raise "Invalid start and end positions" unless valid_move?(start_tower, end_tower)
      @towers[end_tower].push(@towers[start_tower].pop)

    end

    puts "You win!!!!!! (not)"
  end

  def won?
    @towers == [[], [3, 2, 1], []] || @towers == [[], [], [3, 2, 1]]
  end

  private

  def valid_move?(start_tower, end_tower)
    return false if start_tower.nil? || end_tower.nil?
    return false unless start_tower.between?(0, 2) && end_tower.between?(0, 2)
    return false if @towers[start_tower].empty?
    unless @towers[end_tower].last.nil?
      return false if @towers[start_tower].last > @towers[end_tower].last
    end
    true
  end
end
