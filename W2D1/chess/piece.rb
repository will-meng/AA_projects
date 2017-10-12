require 'singleton'

class Piece
  attr_reader :symbol, :team, :board
  attr_accessor :position

  def initialize(board, position, team)
    @board = board
    @position = position
    @team = team
  end

  def valid_moves
    moves.reject do |end_pos|
      board_dup = @board.deep_dup_board
      board_dup.move_piece!(@position, end_pos)
      board_dup.in_check?(@team)
    end
  end

end

module Stepable
  def moves
    result=[]
    @move_dirs.each do |dir|
      final_pos = grow_unblocked_moves_in_dir(dir[0] , dir[1])
      if @board.in_bound(final_pos)
        if !@board[final_pos].is_a?(NullPiece) && @board[final_pos].team != @team
          result << final_pos
        elsif @board[final_pos].is_a?(NullPiece)
          result << final_pos
        end
      end
    end
    result
  end
  private
  def grow_unblocked_moves_in_dir(dx, dy)
    x, y = @position
    [x + dx, y + dy]
  end
end

module Slideable

  def moves
    result = []
    @move_dirs.each do |dir|
      i = 1
      loop do
        final_pos = grow_unblocked_moves_in_dir(dir[0] * i, dir[1] * i)
        if @board.in_bound(final_pos)
          if !@board[final_pos].is_a?(NullPiece) && @board[final_pos].team == @team
            break
          elsif !@board[final_pos].is_a?(NullPiece) && @board[final_pos].team != @team
            result << final_pos
            break
          else
            result << final_pos
          end
        else
          break
        end
        i += 1
      end
    end
    result
  end


private
  def grow_unblocked_moves_in_dir(dx, dy)
    x, y = @position
    [x + dx, y + dy]
  end
end

class Rook < Piece
  include Slideable

  def initialize(board, position, team)
    super
    @move_dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]
    @symbol = team == :white ? "\u2656".encode('utf-8') : "\u265C".encode('utf-8')
  end
end

class Bishop < Piece
  include Slideable

  def initialize(board, position, team)
    super
    @move_dirs = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
    @symbol = team == :white ? "\u2657".encode('utf-8') : "\u265D".encode('utf-8')
  end
end

class Queen < Piece
  include Slideable

  def initialize(board, position, team)
    super
    @move_dirs = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [1, -1], [-1, -1]]
    @symbol = team == :white ? "\u2655".encode('utf-8') : "\u265B".encode('utf-8')
  end
end

class King < Piece
  include Stepable

  def initialize(board, position, team)
    super
    @move_dirs = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [1, -1], [-1, -1]]
    @symbol = team == :white ? "\u2654".encode('utf-8') : "\u265A".encode('utf-8')
  end
end

class Knight < Piece
  include Stepable

  def initialize(board, position, team)
    super
    @move_dirs = [[2, 1], [2, -1], [1, 2], [1, -2], [-2, 1], [-2, -1], [-1, 2], [-1, -2]]
    @symbol = team == :white ? "\u2658".encode('utf-8') : "\u265E".encode('utf-8')
  end
end

class Pawn < Piece

  def initialize(board, position, team)
    super
    @move_dirs = @team == :black ? [1, 0] : [-1, 0]
    @attack_dirs = @team == :black ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
    @symbol = team == :white ? "\u2659".encode('utf-8') : "\u265F".encode('utf-8')
  end

  def in_start_row?
    @team == :black ? @position[0] == 1 : @position[0] == 6
  end

  def moves
    result = []
    x, y = @position

    # moving forward if unblocked
    dx, dy = @move_dirs
    next_pos = [x + dx, y + dy]
    if @board.in_bound(next_pos) && @board[next_pos].is_a?(NullPiece)
      result << next_pos
      two_step_pos = [next_pos[0] + dx, next_pos[1]]
      if in_start_row? && @board[two_step_pos].is_a?(NullPiece)
        result << two_step_pos
      end
    end

    # attacking diagonally forward
    @attack_dirs.each do |dir|
      dx, dy = dir
      next_pos = [x + dx, y + dy]
      if @board.in_bound(next_pos)
        unless @board[next_pos].is_a?(NullPiece) || @board[next_pos].team == @team
          result << next_pos
        end
      end
    end

    result
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
    @team = nil
    @symbol = ' '
  end

  def moves
    []
  end

end
