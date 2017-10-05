require_relative 'Card'

class Board

  def initialize(size = [4, 5])
    @size = size
    @grid = Array.new(size[0]) { Array.new(size[1]) }
  end

  def populate
    num_cards = @size[0] * @size[1]
    card_pool = (0...num_cards).to_a.map { |n| n / 2 }.shuffle

    @grid.each_with_index do |row, i|
      row.each_with_index do |_, j|
        @grid[i][j] = Card.new(card_pool.pop)
      end
    end
  end

  def render
    # system 'clear'
    @grid.each do |row|
      row.each do |el|
        print "|#{el.to_s}"
      end
      print "|"
      puts
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = value
  end

  def won?
    @grid.all? do |row|
      row.all?(&:face_up)
    end
  end

  def reveal(pos)
    return if @grid[pos[0]][pos[1]].face_up
    @grid[pos[0]][pos[1]].reveal
    @grid[pos[0]][pos[1]].value
  end

end
