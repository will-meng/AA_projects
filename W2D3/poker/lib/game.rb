require_relative 'deck'
require_relative 'player'

class Game
  attr_reader :pot, :deck, :players

  def initialize
    @pot = 0
    @deck = Deck.new
  end

  def add_players(num, bankroll)
    @players = Array.new(num) { Player.new(bankroll) }
  end

  def game_over?
    players.reject { |player| player.bankroll.zero? }.length == 1
  end

  def deal_cards
    players.each do |player|
      player.deal_in(@deck.deal_hand) unless player.bankroll.zero?
    end
  end

  def add_to_pot(amt)
    @pot += amt
    amt
  end
end
