class Hand
  attr_reader :cards

  RANKS = [:high_card, :one_pair, :two_pair, :three_of_a_kind, :straight, :flush,
          :full_house, :four_of_a_kind, :straight_flush, :royal_flush]

  def initialize(cards)
    raise 'must have five cards' unless cards.count == 5
    @cards = cards # [card1, card2, card3, card4, card5]
  end

  def trade_cards(take_cards, new_cards)
    take_cards.each do |card|
      raise 'cannot discard unowned card' unless cards.delete(card)
    end
    raise 'must have five cards' unless cards.concat(new_cards).length == 5
  end

  def <=>(other_hand)
    result = rank_value(rank) <=> rank_value(other_hand.rank)
    result.zero? ? break_tie(other_hand, rank) : result
  end

  def self.winner(hands)
    winner = hands.first
    hands[1..-1].each do |hand|
      winner = hand if (hand <=> winner) == 1
    end
    winner
  end

  def rank
    RANKS.reverse.each_with_index do |rank, i|
      next if i == RANKS.length - 1
      return rank if send(rank)
    end
    RANKS.first
  end

  def rank_value(rank)
    RANKS.index(rank)
  end

  private

  def break_tie(other_hand, rank)
    sort_hand!
    case rank
    when :royal_flush
      break_royal_flush(other_hand)
    when :straight_flush, :straight
      break_straight(other_hand)
    when :four_of_a_kind
      break_n_of_a_kind(other_hand, 4)
    when :full_house, :three_of_a_kind
      break_n_of_a_kind(other_hand, 3)
    when :two_pair
      break_two_pair(other_hand)
    when :one_pair
      break_n_of_a_kind(other_hand, 2)
    else
      # flush and high_card just compare high cards
      break_high_card(cards, other_hand.cards)
    end
  end

  def break_royal_flush(other_hand)
    cards.first <=> other_hand.cards.first
  end

  def break_straight(other_hand)
    # check 2nd highest card in case :ace is part of straight
    @cards[1] <=> other_hand.cards[1]
  end

  def break_n_of_a_kind(other_hand, n)
    values1 = values
    n_card = nil
    values1.each_with_index do |val, i|
      if values1.count(val) == n
        n_card = cards[i].poker_value
        break
      end
    end

    values2 = other_hand.values
    other_n_card = nil
    values2.each_with_index do |val, i|
      if values2.count(val) == n
        other_n_card = other_hand.cards[i].poker_value
        break
      end
    end

    first_check = n_card <=> other_n_card
    return first_check unless first_check == 0
    remaining1 = cards.reject { |card| card.poker_value == n_card }
    remaining2 = other_hand.cards.reject { |card| card.poker_value == other_n_card }
    break_high_card(remaining1, remaining2)
  end

  def break_two_pair(other_hand)
    values_arr = [poker_values, other_hand.poker_values]
    pairs, high_pair, low_pair, kicker = [], [], [], []
    values_arr.each_with_index do |arr, i|
      pairs << arr.select { |val| arr.count(val) == 2 }
      high_pair << pairs[i].max
      low_pair << pairs[i].min
      kicker << (arr - pairs[i]).first
    end

    return 1 if high_pair.first > high_pair.last
    return -1 if high_pair.first < high_pair.last
    return 1 if low_pair.first > low_pair.last
    return -1 if low_pair.first < low_pair.last
    kicker.first <=> kicker.last
  end

  def break_high_card(cards1, cards2)
    cards1.each_with_index do |card, i|
      result = card <=> cards2[i]
      return result unless result == 0
    end
    0
  end

  def sort_hand!
    # returns highest card in lowest index
    @cards.sort_by!(&:poker_value).reverse!
  end

  def n_of_a_kind?(n)
    values_arr = values
    !values_arr.select { |val| values_arr.count(val) == n }.empty?
  end

  def one_pair
    n_of_a_kind?(2)
  end

  def two_pair
    values_arr = values
    pairs = values_arr.select { |val| values_arr.count(val) == 2 }
    pairs.length == 4
  end

  def three_of_a_kind
    n_of_a_kind?(3)
  end

  def four_of_a_kind
    n_of_a_kind?(4)
  end

  def full_house
    return false unless three_of_a_kind
    values_arr = values
    last_two = values_arr.reject { |val| values_arr.count(val) == 3 }
    last_two.first == last_two.last
  end

  def straight
    sort_hand!

    @cards.each_with_index do |card, i|
      # special exception for [:ace, :five, :four, :three, :two]
      next if i == 4 || (i == 0 && cards[0].value == :ace && cards[1].value == :five)
      cur_val = card.poker_value
      next_val = cards[i + 1].poker_value
      return false unless next_val == cur_val - 1
    end
    true
  end

  def flush
    first_suit = @cards.first.suit
    cards.all? { |card| card.suit == first_suit }
  end

  def straight_flush
    straight && flush
  end

  def royal_flush
    # check for a :king as 2nd card in straight flush
    straight_flush && cards[1].value == Card.values[-2]
  end

  protected

  def values
    @cards.map(&:value)
  end

  def poker_values
    @cards.map(&:poker_value)
  end
end
