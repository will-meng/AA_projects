require 'poker'
require 'rspec'


RSpec.describe Card do
  subject(:card) {Card.new(:A, :spades) }
  describe '#initialize' do
    it 'assigns a suit' do
      expect(card.suit).to eq(:spades)
    end
    it 'assigns a value' do
      expect(card.value).to eq(:A)
    end
  end
end

RSpec.describe Deck do
  subject(:deck) { Deck.new }
  let(:another_deck) { Deck.new }

  describe '#initialize' do

    it 'creates an array of cards' do
      expect(deck.cards).to be_an_instance_of Array
    end

    it 'contains 52 cards' do
      expect(deck.cards.length).to eq(52)
      expect(deck.cards.all? { |el| el.is_a?(Card) }).to be_truthy
    end

    it 'has 4 cards in a value' do
      expect(deck.cards.select { |card| card.value == :A }.count).to eq(4)
    end
  end

  describe '#shuffle' do
    it 'shuffles the cards' do
      expect(deck.shuffle.first.value).to_not eq(another_deck.shuffle.first.value)
    end
  end

  describe '#deal_card' do
    it 'removes card from deck' do
      deck.deal_card
      expect(deck.cards.length).to eq(51)
    end

    it 'returns dealt card' do
      expect(deck.deal_card).to be_a(Card)
    end
  end
end

RSpec.describe Hand do
  four_of_a_kind =
    [Card.new(:A, :spades), Card.new(:A, :hearts), Card.new(:A, :clubs),
     Card.new(:A, :diamonds), Card.new(2, :spades)]
  pair =
    [Card.new(7, :spades), Card.new(7, :hearts), Card.new(:J, :clubs),
     Card.new(10, :diamonds), Card.new(3, :spades)]
  another_pair =
    [Card.new(:K, :clubs), Card.new(:K, :diamonds), Card.new(:Q, :clubs),
     Card.new(5, :diamonds), Card.new(4, :spades)]

  subject(:hand) { Hand.new(pair) }

  describe '#initialize' do
    it 'takes 5 cards as arguments' do
      expect(hand.hand.length).to eq(5)
    end

  describe '#beat?' do

    it 'takes 1 argument representing another hand' do
      hand.beat?(another_pair)
      expect(hand).to_receive(:beat?).with(another_pair)
    end

    context 'when one hand has higher rank' do
      winning_hand = Hand.new(four_of_a_kind)
      it 'returns true if receiver hand won' do
      expect(winning_hand.beat?(hand)).to be true
      end
    end

    context 'when both hands have same rank' do
      winning_hand = Hand.new(another_pair)
      it 'returns false if receiver hand lost' do
        expect(pair.beat?(winning_hand)).to be false
      end
    end
  end
  end
end
