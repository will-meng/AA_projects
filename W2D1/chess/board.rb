require_relative 'piece'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
    8.times do |n|
      @grid[1][n] = Pawn.new(self, [1, n], :black)
      @grid[6][n] = Pawn.new(self, [6, n], :white)
    end
    @grid[0][0] = Rook.new(self, [0, 0], :black)
    @grid[0][7] = Rook.new(self, [0, 7], :black)
    @grid[7][0] = Rook.new(self, [7, 0], :white)
    @grid[7][7] = Rook.new(self, [7, 7], :white)
    @grid[0][1] = Knight.new(self, [0, 1], :black)
    @grid[0][6] = Knight.new(self, [0, 6], :black)
    @grid[7][1] = Knight.new(self, [7, 1], :white)
    @grid[7][6] = Knight.new(self, [7, 6], :white)
    @grid[0][2] = Bishop.new(self, [0, 2], :black)
    @grid[0][5] = Bishop.new(self, [0, 5], :black)
    @grid[7][2] = Bishop.new(self, [7, 2], :white)
    @grid[7][5] = Bishop.new(self, [7, 5], :white)
    @grid[0][3] = Queen.new(self, [0, 3], :black)
    @grid[0][4] = King.new(self, [0, 4], :black)
    @grid[7][3] = Queen.new(self, [7, 3], :white)
    @grid[7][4] = King.new(self, [7, 4], :white)
  end

  def move_piece(start_pos, end_pos, color)
    unless start_pos == end_pos
      x, y = start_pos
      m, n = end_pos
      moved_piece = @grid[x][y]
      raise "No Piece at starting position" if moved_piece.nil?
      raise "You cannot move that color" unless moved_piece.team == color
      raise "Invalid move" unless moved_piece.valid_moves.include?(end_pos)
      @grid[m][n] = moved_piece
      @grid[x][y] = NullPiece.instance
      moved_piece.position = end_pos
    end
  end

  def move_piece!(start_pos, end_pos)
    x, y = start_pos
    m, n = end_pos
    @grid[m][n] = @grid[x][y]
    @grid[x][y] = NullPiece.instance
    @grid[x][y].position = end_pos
  end

  def in_bound(pos)
    x, y = pos
    x < 8 && x >= 0 && y < 8 && y >= 0
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def in_check?(team)
    king_pos=nil
    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece.is_a?(King) && piece.team == team
          king_pos=[i,j]
          break
        end
      end
    end

    @grid.each do |row|
      row.each do |piece|
        return true if piece.team != team && !piece.is_a?(NullPiece) &&
                       piece.moves.include?(king_pos)
      end
    end
    false
  end

  def checkmate?(team)
    if in_check?(team)
      @grid.each do |row|
        row.each do |piece|
          return false if piece.team == team && !piece.valid_moves.empty?
        end
      end
      true
    else
      false
    end
  end

  def deep_dup_board
    board_dup = self.class.new
    board_dup.grid = @grid.deep_dup(board_dup)
    board_dup
  end

  # def deep_dup
  #   board_dup = self.dup
  #
  #   board_dup.grid.each_with_index do |row, i|
  #     board_dup[i] = row.dup
  #     row.each_with_index do |piece, j|
  #       unless piece.is_a?(NullPiece)
  #         piece_dup = piece.dup
  #         piece_dup.position = piece.position.dup
  #         board_dup[[i, j]] = piece_dup
  #       end
  #     end
  #   end
  #   board_dup
  # end

end

class Array
  def deep_dup(board)
    self.map do |el|
      if el.is_a?(Array)
        el.deep_dup(board)
      else
        el.is_a?(NullPiece) ? el : el.class.new(board, el.position.dup, el.team)
      end
    end
  end
end
