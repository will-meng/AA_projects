require 'methods'
require 'rspec'


RSpec.describe Array do

  describe '#my_uniq' do
    it 'removes duplicate elements from origin array' do
      expect([1, 2, 2, 3].my_uniq).to eq([1, 2, 3])
    end
  end

  describe '#two_sum' do
    subject(:arr) { [-1, 0, 2, -2, 1] }

    it 'returns an array of pairs' do
      expect(arr.two_sum).to be_a Array
    end

    it 'returns pairs in order' do
      expect(arr.two_sum).to eq([[0, 4], [2, 3]])
    end
  end

  describe '#my_transpose' do
    subject(:arr) { [[0, 1, 2],
                     [3, 4, 5],
                     [6, 7, 8]] }

    it 'accepts a nested array' do
      expect { [1, 2, 3].my_transpose }.to raise_error(ArgumentError)
    end

    it 'transposes rows and columns' do
      expect(arr.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end
  end

  describe '#stock_picker' do
    subject(:prices) { [8.3, 4.6, 9.8, 9.9, 7.4, 8.2] }

    it 'outputs a sell date later than buy date' do
      expect(prices.stock_picker.sort).to eq(prices.stock_picker)
      expect(prices.stock_picker.length).to eq(2)
    end

    it 'maximizes profit' do
      expect(prices.stock_picker).to eq([1, 3])
    end

    it 'minimizes loss if price is continuosly dropping' do
      expect([10.4, 6.7, 5.4, 5.4, 0.2].stock_picker).to eq([2, 3])
    end
  end
end

RSpec.describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }

  describe '#initialize' do
    it 'defaults to a regular tower structure with no arguments' do
      expect(game.towers).to eq([[3, 2, 1], [], []])
    end
  end

  describe 'move' do
    it 'prompts user for a move' do
      allow($stdin).to receive(:gets)
    end

    context 'with input that is bad' do
      before { $stdin = StringIO.new("bad input") }

      it 'raises an error' do
        expect { game.move }.to raise_error("Invalid start and end positions")
      end
    end

    # context 'with valid data type but invalid values' do
    #   before { $stdin = StringIO.new("4, 5") }
    #
    #   it 'raises another error' do
    #     expect { game.move }.to raise_error("Invalid start and end positions")
    #   end
    # end

    context 'with valid data type and invalid values' do
      before { $stdin = StringIO.new("0, 1") }

      it 'changes towers correctly' do
        game.move
        expect(game.towers).to eq([[3, 2], [1], []])
      end
    end
  end

  describe 'won?' do
    subject(:winninggame) { TowersOfHanoi.new([[], [3, 2, 1], []]) }
    it 'checks if complete tower is in 2nd or 3rd position' do
      expect(winninggame.won?).to be true
    end
  end
end
