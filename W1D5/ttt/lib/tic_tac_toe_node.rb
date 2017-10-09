require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    opponent_mark = evaluator == :o ? :x : :o
    return true if @board.over? && @board.winner == opponent_mark
    return false if @board.over? && @board.winner != opponent_mark
    children.all? do |child|
      child.losing_node?(evaluator)
    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
  end
end
