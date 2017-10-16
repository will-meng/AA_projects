class HumanPlayer

  def initialize(name = 'JW')
    @name = name
  end

  def get_guess
    print 'Guess a card position (e.g. "1, 2"): '
    gets.chomp.strip.split(',').map(&:to_i)
  end

  def receive_revealed_card(_); end
end

class AIPlayer
  def initialize(size, name = "Watson:")
    @name = name
    @board = Array.new(size[0]) { Array.new(size[1]) { Card.new(nil) } }
    @previous_guess = nil
    @current_guess = nil
  end

  def get_guess
    moves = possible_moves
    @current_guess = moves.sample
    puts "Previous guess: #{@previous_guess}"
    if @previous_guess
      previous_value = @board[@previous_guess[0]][@previous_guess[1]].value
      pair = find_pair_second(previous_value, moves)
    else

      pair = find_pair_first(moves)
    end
    if pair
      @current_guess = pair
    end


    @current_guess
  end

  def receive_revealed_card(value)
    @board[@current_guess[0]][@current_guess[1]] = Card.new(value)
    current_card = @board[@current_guess[0]][@current_guess[1]]
    if @previous_guess
      puts "the previous guess is #{@previous_guess}"
      previous_card = @board[@previous_guess[0]][@previous_guess[1]]
      if current_card == previous_card
        current_card.reveal
        previous_card.reveal
      end
    end
    puts "AI Board"
    render
    @previous_guess = @previous_guess ? nil : @current_guess
  end

  private

  def find_pair_second(value, moves)
    moves.each do |pos|
      if @board[pos[0]][pos[1]].value == value
        puts "I know the second position: #{pos}"
        return pos
      end
    end
    nil
  end

  def find_pair_first(moves)
    0.upto(moves.length - 2) do |i|
      (i + 1).upto(moves.length - 1) do |j|
        value1 = @board[moves[i][0]][moves[i][1]].value
        value2 = @board[moves[j][0]][moves[j][1]].value
        if value1 && value1 == value2
          puts "I already know a match at #{moves[i]}"
          return moves[i]
        end
      end
    end
    nil
  end

  def possible_moves
    moves = []
    @board.each_with_index do |row, i|
      row.each_with_index do |card, j|
        moves << [i, j] unless card.face_up || @previous_guess == [i, j]
      end
    end
    p moves
  end

  def render
    puts
    @board.each do |row|
      row.each do |el|
        print "|#{el.value || 'X'} #{'*' if el.face_up}"
      end
      print "|"
      puts
    end
  end

end
