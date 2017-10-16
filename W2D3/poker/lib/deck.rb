require_relative 'card'
require_relative 'hand'

class Deck
  def initialize(cards = self.class.all_cards)
    @cards = cards
  end

  def self.all_cards
    cards = []
    Card.values.each do |val|
      Card.suits.each { |suit| cards << Card.new(suit, val) }
    end
    cards
  end

  def count
    @cards.count
  end

  def take(n)
    raise 'not enough cards' if n > count
    @cards.shift(n)
  end

  def return(cards)
    @cards.concat(cards)
  end

  def deal_hand
    Hand.new(take(5))
  end

  def shuffle
    @cards.shuffle!
  end
end
