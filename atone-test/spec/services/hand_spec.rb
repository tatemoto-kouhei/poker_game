require "../../app/services/hand.rb"
require "pry"

describe Card do
  context 'when validating cards' do
    it 'validates a valid card' do
      card = Card.new('S', '12')
      expect(card.valid?).to be true
    end

    it 'does not validate an invalid card' do
      card = Card.new('X', '99')
      expect(card.valid?).to be false
    end
  end
end

describe Hand do
  context 'when adding cards to hand' do
    it 'adds a valid card to the hand' do
      hand = Hand.new
      card = Card.new('D', '3')
      hand.add_card(card)
      expect(hand.cards).to include(card)
    end

    it 'does not add an invalid card to the hand' do
      hand = Hand.new
      card = Card.new('P', '9')
      expect { hand.add_card(card) }.to raise_error(ArgumentError)
      expect(hand.cards).not_to include(card)
    end

    it 'input valid string' do
      deck = Deck.new
      hand = Hand.new
      input_string = 'S13 D3 C2 D11 H2'
      expected_cards = [
        Card.new('S','13'),
        Card.new('D','3'),
        Card.new('C','2'),
        Card.new('D','11'),
        Card.new('H','2')
      ]
      hand.convert_string_to_hand(input_string,deck)
      expect(hand.cards).to eq(expected_cards)
    end

  end
end

describe Deck do
  context 'when adding cards to the deck' do
    it 'adds a card to the deck' do
      deck = Deck.new
      card = Card.new('H', '2')
      deck.add_card(card)
      expect(deck.cards).to include(card)
    end

    it 'does not add a duplicate card to the deck' do
      deck = Deck.new
      card1 = Card.new('S', '12')
      card2 = Card.new('S', '12')
      deck.add_card(card1)
      expect { deck.add_card(card2) }.to raise_error(ArgumentError)
      expect(deck.cards).to include(card1)
    end
  end
end

