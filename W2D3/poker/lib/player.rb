class Player
  attr_reader :bankroll, :hand, :folded

  def initialize(bankroll)
    @bankroll = bankroll
    @hand = nil
    @folded = false
    @prev_bet = 0
  end

  def self.buy_in(bankroll)
    Player.new(bankroll)
  end

  def deal_in(hand)
    @prev_bet = 0
    @hand = hand
  end

  def take_bet(bet_amt)
    @bankroll += @prev_bet
    raise 'not enough money' if bet_amt > bankroll
    @bankroll -= bet_amt
    @prev_bet = bet_amt
  end

  def receive_winnings(won_amt)
    @bankroll += won_amt
  end

  def return_cards
    cards = @hand.cards
    @hand = nil
    cards
  end

  def folded?
    folded
  end

  def fold
    @folded = true
  end

  def unfold
    @folded = false
  end
end
