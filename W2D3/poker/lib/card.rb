class Card
  attr_reader :value, :suit

  VALUES = [:two, :three, :four, :five, :six, :seven, :eight, :nine,
            :ten, :jack, :queen, :king, :ace].freeze
  SUITS = [:diamonds, :clubs, :hearts, :spades].freeze

  def initialize(suit, value)
    raise 'Invalid Suit' unless SUITS.include?(suit)
    raise 'Invalid Value' unless VALUES.include?(value)
    @suit = suit
    @value = value
  end

  def <=>(other_card)
    if value == other_card.value && suit == other_card.suit
      0
    elsif value != other_card.value
      poker_value <=> other_card.poker_value
    else
      suits_value <=> other_card.suits_value
    end
  end

  def self.values
    VALUES
  end

  def self.suits
    SUITS
  end

  def poker_value
    VALUES.index(value)
  end

  def suits_value
    SUITS.index(suit)
  end
end
