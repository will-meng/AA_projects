require 'colorize'

BOARD_SIZE = 16
BOMB = "B"
FLAG = "F  ".colorize(:yellow)
UNKNOWN = '*  '.colorize(:light_white)
ZERO = '   '
HASH = {1 => "1".colorize(:light_blue),
        2 => "2".colorize(:green),
        3 => "3".colorize(:light_red),
        4 => "4".colorize(:blue),
        5 => "5".colorize(:red),
        6 => "6".colorize(:cyan),
        7 => "7".colorize(:light_black),
        8 => "8".colorize(:white),
        "B" => "B".colorize(:red),
        nil => '  '}

class Board
  def initialize(num_bombs)
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    @num_bombs = num_bombs
    populate

  end

  def render
    system 'clear'
    # puts "   #{(0...BOARD_SIZE).to_a.join(" ")}".colorize(:red)
    print ' '
    (0...BOARD_SIZE).each { |n| print "#{'%3s' % n.to_s}".colorize(:red) }
    puts
    @grid.each_with_index do |row, i|
      print "#{"%2s" % i.to_s} ".colorize(:red)
      row.each do |tile|
      symbol = if tile.visible
                 tile.value == 0 ? ZERO : "#{HASH[tile.value]}  "
               elsif tile.flagged
                 FLAG
               else
                 UNKNOWN
               end
      print symbol
      end
      puts
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def reveal(pos, tile)
    value = tile.reveal

    if value == 0
      neighbors(pos).each do |neighbor, n_pos|
        reveal(n_pos, neighbor) if neighbor.value == 0 && !neighbor.visible
        neighbor.reveal
      end
    end

    value
  end

  def won?
    @grid.each do |row|
      row.each do |tile|
        return false if !tile.visible && tile.value != BOMB
      end
    end
    true
  end

  private

  def neighbors(pos)
    result = []
    (pos[0] - 1..pos[0] + 1).each do |row|
      (pos[1] - 1..pos[1] + 1).each do |col|
        next unless row.between?(0, BOARD_SIZE - 1) && col.between?(0, BOARD_SIZE - 1)
        result << [@grid[row][col], [row, col]] unless [row, col] == pos
      end
    end
    result
  end

  def populate
    populate_bombs
    @grid.each_with_index do |row, i|
      row.each_with_index do |el, j|
        next if el.is_a?(Tile)
        @grid[i][j] = Tile.new(bombs_adjacent([i, j]))
      end
    end
  end

  def bombs_adjacent(pos)
    count = 0
    neighbors(pos).each do |neighbor, _pos|
      if neighbor.is_a?(Tile)
        count += 1 if neighbor.value == BOMB
      end
    end
    count
  end

  def populate_bombs
    bomb_positions.each do |pos|
      @grid[pos[0]][pos[1]] = Tile.new(BOMB)
    end
  end

  def bomb_positions
    positions = []
    until positions.length == @num_bombs
      pos = [rand(BOARD_SIZE), rand(BOARD_SIZE)]
      positions << pos unless positions.include?(pos)
    end
    positions
  end
end

class Tile
  attr_reader :value, :visible, :flagged

  def initialize(value)
    @visible = false
    @flagged = false
    @value = value
  end

  def reveal
    @visible = true
    @value
  end

  def toggle_flag
    @flagged = flagged == true ? false : true
  end

end

class Player

  def get_input
    puts "Enter a position and 'f' for flag or 'r' for reveal (e.g. '2,5,r'): "
    gets.chomp.strip.split(',')
  rescue
    retry
  end

end

class Minesweeper
  attr_reader :board

  def initialize(num_bombs)
    @board = Board.new(num_bombs)
    @player = Player.new
    @game_over = false
  end

  def play
    until @game_over || board.won?
      board.render
      begin
        x, y, z = @player.get_input
        parse_input([x.to_i, y.to_i], z)
      rescue => e
        puts e.message
        retry
      end
    end
    board.render
    conclude_message
  end

  def parse_input(pos, action)
    if !pos[0].between?(0, BOARD_SIZE - 1) || !pos[1].between?(0, BOARD_SIZE - 1)
      raise "Invalid position."
    end
    tile = board[pos]
    raise "That square is already revealed." if tile.visible
    raise "Unknown action '#{action}'." unless ['r', 'f'].include?(action)


    if action.casecmp('r').zero?
      @game_over = true if board.reveal(pos, tile) == BOMB
    else
      tile.toggle_flag
    end
  end

  def conclude_message
    puts board.won? ? "Congratulations, you win!" : "Sorry, game over!"
  end

end

Minesweeper.new(40).play
