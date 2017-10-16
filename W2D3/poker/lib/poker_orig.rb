class Card
  attr_reader :value, :suit

  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A].freeze
  SUITS = [:spades, :hearts, :clubs, :diamonds].freeze

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def values
    VALUES
  end

  def suits
    SUITS
  end

  def poker_value
    VALUES.index(value)
  end

end

class Deck

  def self.all_cards
    cards = []
    Card.values.each do |value|
      Card.suits.each { |suit| cards << Card.new(value, suit) }
    end
    cards
  end

  def initialize(cards = self.class.all_cards)
    @cards = cards
  end

  def shuffle
    @cards.shuffle!
  end

  def take(n)
    raise "not enough cards" if n > @cards.count
    result = []
    n.times { result << @cards.pop }
    result
  end
end

class Hand
  attr_reader :hand

  RANKS = [:single, :pair, :two_pairs, :three_of_a_kind, :straight, :flush,
          :full_house, :four_of_a_kind, :straight_flush, :royal_flush]

  def initialize(card_arr)
    @hand = card_arr
    # [card1, card2, card3, card4, card5]
  end

  def beat?(other_hand)
    case rank_value <=> other_hand.rank_value
    when 1
      return true
    when -1
      return false
    when 0


    end
  end

  def rank
    RANKS.reverse.each do |rank|
      return rank if send(rank)
    end
  end

  def rank_value
    RANKS.index(rank)
  end

  private

  def two_pairs

  end

  def n_of_a_kind?(n)
    values = @hand.map { |card| card.value }
    !values.select { |val| values.count(val) == n }.empty?
  end

  def full_house
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end

  def straight
    sort_hand!

    @hand.each_with_index do |card, i|
      next if i == 4
      cur_val = card.poker_value
      next_val = @hand[i + 1].poker_value
      return false unless next_val == cur_val - 1
    end
    true
  end

  def flush
    first_suit = @hand.first.suit
    @hand.all? { |card| card.suit == first_suit }
  end

  def straight_flush
    @hand.straight && @hand.flush
  end

  def royal_flush
    @hand.straight_flush && @hand.last.value == :A
  end

  def sort_hand!
    # returns highest card in lowest index
    @hand.sort_by!(&:poker_value).reverse!
  end

end
