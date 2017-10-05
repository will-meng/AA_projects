require_relative 'Board'
require_relative 'Solver'

class Game
  def initialize(file = 'sudoku1.txt')
    @player = Solver.new
    @board = Board.from_file(file)
  end

  def play
    until @board.solved?
      @board.render
      # gets
      print 'Enter a position (e.g. "0,0"): '
      # pos = gets.chomp.strip.split(',').map(&:to_i)
      pos = @player.get_position
      print 'Enter a number for that position: '
      # value = gets.chomp.strip
      value = @player.get_value
      puts "Vaild move: #{@board.valid_move?(pos, value)}"
      @board.update(pos, value) if @board.valid_move?(pos, value)
    end
    puts "You've won!"
  end
end

Game.new.play
