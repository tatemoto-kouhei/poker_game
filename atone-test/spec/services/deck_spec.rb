require 'rails_helper'

describe "Deck" do
#カードをデッキに正しく追加できているか
  context '#add_card' do
    it 'デッキにカードを追加する' do
      deck = Deck.new
      card = Card.new('H', '2')
      deck.add_card(card)
      expect(deck.cards).to include(card)
    end

    #重複したカードがデッキに追加された際にエラーを返すか
    it '追加するカードが既にデッキ内に存在している' do
      deck = Deck.new
      card1 = Card.new('S', '12')
      card2 = Card.new('S', '12')
      deck.add_card(card1)
      expect { deck.add_card(card2) }.to raise_error(ArgumentError)
      expect(deck.cards).to include(card1)
    end
  end
end

