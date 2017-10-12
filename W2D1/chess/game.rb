require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game

  def initialize(player1, player2)
    @board = Board.new
    @display = Display.new(@board)
    @player1 = player1
    @player2 = player2
    @current_player = [player1, :white]
  end

  def play
    until @board.checkmate?(:white) || @board.checkmate?(:black)
      begin
        input = @current_player[0].play_turn(@display, @current_player[1])
        @board.move_piece(input[0], input[1], @current_player[1])
      rescue => e
        puts e.message
        sleep(2)
        retry
      end

      #switch players
      @current_player =
        @current_player[0] == @player1 ? [@player2, :black] : [@player1, :white]
    end

    puts "Game over!"
  end

end

if $PROGRAM_NAME == __FILE__
  player1 = Player.new("William")
  player2 = Player.new("Alex")
  Game.new(player1, player2).play
end
