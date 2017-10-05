class Game
  MIN_LENGTH = 3
  attr_reader :players, :current_player, :fragment

  def initialize
    @players = [Player.new("Player1"), Player.new("Player2")]
    @fragment = ""
    @dictionary = []
    File.foreach("dictionary.txt") { |line| @dictionary << line.chomp }
    @current_player = @players[0]
  end

  def play
    play_round until game_over?
    conclude
  end

  def play_round
    take_turn(current_player)
    update_dictionary
    switch_player!
  end

  def take_turn(player)
    guess = ""
    loop do
      guess = player.get_play
      break if valid_play?(guess)
      puts "Invalid move!"
    end
    fragment << guess
    p fragment
  end

  private

  attr_reader :dictionary

  def conclude
    puts "#{current_player.name} has won! #{fragment} is a complete word!"
    exit
  end

  def check_dictionary(str)
    dictionary.any? { |word| word.start_with?(fragment + str) }
  end

  def game_over?
    dictionary.any? { |word| word == fragment && fragment.length >= MIN_LENGTH }
  end

  def switch_player!
    @current_player = current_player == players[0] ? players[1] : players[0]
  end

  def update_dictionary
    @dictionary = dictionary.select { |word| word.start_with?(fragment) }
  end

  def valid_play?(str)
    ("a".."z").to_a.include?(str) && check_dictionary(str)
  end

end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_play
    puts "#{self.name}, what's your play?"
    gets.chomp.downcase
  end

end

Game.new.play if $PROGRAM_NAME == __FILE__
