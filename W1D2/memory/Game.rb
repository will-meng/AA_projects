require_relative 'Board'
require_relative 'Player'

class Game

  def initialize(player = AIPlayer.new([40, 5]))
    @player = player
    @board = Board.new([40, 5])
    @board.populate
  end

  def play
    until @board.won?
      # @board.render
      guesses = []
      values = []
      2.times do |n|
        guesses[n] = @player.get_guess
        values[n] = @board.reveal(guesses[n])
        puts "Game Board"
        @board.render
        @player.receive_revealed_card(values[n])
        # gets
      end
      unless values.first == values.last
        @board[guesses.first].hide
        @board[guesses.last].hide
        # sleep(3)
      end
    end
    puts "Game Over!"
  end



end

Game.new.play if $PROGRAM_NAME == __FILE__
