class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end

class Deck
  attr_reader :cards
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A].freeze
  SUITS = [:spades, :hearts, :clubs, :diamonds].freeze

  def initialize
    @cards = []
    VALUES.each do |value|
      SUITS.each do |suit|
        @cards << Card.new(value, suit)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end

class Hand
  attr_reader :hand

  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A].freeze
  SUITS = [:spades, :hearts, :clubs, :diamonds].freeze
  RANK = [:royal_flush, :straight_flush, :four_of_a_kind, :full_house,
          :flush, :straight, :three_of_a_kind, :two_pairs, :pair].freeze

  def initialize(card_arr)
    @hand = card_arr
    # [card1, card2, card3, card4, card5]
  end

  def beat?(other_hand)


  end

  private

  def straight?
    sort_hand!

    @hand.each_with_index do |card, i|
      next if i == 4
      cur_idx = VALUE.index(card.value)
      next_idx = VALUE.index(sorted_hand[i + 1].value)
      return false unless next_idx == cur_idx + 1
    end
    true
  end

  def flush?
    first_suit = @hand.first.suit
    @hand.all? { |card| card.suit == first_suit }
  end

  def straight_flush?
    @hand.straight? && @hand.flush?
  end

  def royal_flush?
    sort_hand!
    @hand.straight_flush? &&
  end

  def sort_hand!
    @hand.sort_by! { |card| VALUES.index(card.value) }
  end

end
