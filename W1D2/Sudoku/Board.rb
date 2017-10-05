require_relative 'Tile'
require 'colorize'

class Board
  SOLVED_ROW = ('1'..'9').to_a

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file_name)
    values = File.readlines(file_name).map { |el| el.chomp.split('') }

    grid = []
    values.each do |row|
      grid << row.map { |e| Tile.new(e, e.to_i > 0) }
    end
    Board.new(grid)
  end

  def update(pos, value)
    @grid[pos[0]][pos[1]].update(value)
  end

  def check_line(lines)
    lines.each do |line|
      line_array = []
      line.each { |tile| line_array << tile.value }
      return false unless line_array.sort == SOLVED_ROW
    end
    true
  end

  def solved?
    check_line(@grid) && check_line(@grid.transpose)
  end

  def render
    i = 0
    @grid.each do |row|
      j = 0
      row.each do |tile|
        print " #{tile.to_s}"
        j += 1
        print "|" if j % 3 == 0
      end
      i += 1
      puts
      (i % 3 == 0) ? puts('-' * (row.length * 2) + '-' * 3) : puts
      # puts ' -' * row.length
    end
  end

  def valid_move?(pos, value)
    return false if value_in_line(@grid[pos[0]], value)
    return false if value_in_line(@grid.transpose[pos[1]], value)
    return false if value_in_line(get_square(pos), value)
    true
  end

  def value_in_line(line, value)
    line.map { |tile| tile.value }
        .include?(value)
  end

  def get_square(pos)
    result = []
    bins = [[0,1,2],[3,4,5],[6,7,8]]
    rows = bins.select { |bin| bin.include? pos[0] }
    cols = bins.select { |bin| bin.include? pos[1] }
    rows[0].each do |i|
      cols[0].each { |j| result << @grid[i][j] }
    end
    result
  end

end
