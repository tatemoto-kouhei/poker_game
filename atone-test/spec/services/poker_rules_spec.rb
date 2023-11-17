require 'rails_helper'

describe "PokerRules" do
  let(:hand) { Hand.new }

  context 'ポーカーの役を評価する' do
    it 'ストレートフラッシュ' do
      hand.add_card(Card.new('H', '9'))
      hand.add_card(Card.new('H', '8'))
      hand.add_card(Card.new('H', '7'))
      hand.add_card(Card.new('H', '6'))
      hand.add_card(Card.new('H', '5'))

      expect(PokerRules::evaluate(hand)).to eq('ストレートフラッシュ')
    end

    it 'フォーカード' do
      hand.add_card(Card.new('C', '4'))
      hand.add_card(Card.new('D', '4'))
      hand.add_card(Card.new('H', '4'))
      hand.add_card(Card.new('S', '4'))
      hand.add_card(Card.new('D', '7'))

      expect(PokerRules::evaluate(hand)).to eq('フォーカード')
    end

    it 'フルハウス' do
      hand.add_card(Card.new('S', '6'))
      hand.add_card(Card.new('H', '6'))
      hand.add_card(Card.new('D', '6'))
      hand.add_card(Card.new('H', '9'))
      hand.add_card(Card.new('C', '9'))

      expect(PokerRules::evaluate(hand)).to eq('フルハウス')
    end

    it 'フラッシュ' do
      hand.add_card(Card.new('D', '2'))
      hand.add_card(Card.new('D', '8'))
      hand.add_card(Card.new('D', '4'))
      hand.add_card(Card.new('D', '7'))
      hand.add_card(Card.new('D', '13'))

      expect(PokerRules::evaluate(hand)).to eq('フラッシュ')
    end

    it 'ストレート' do
      hand.add_card(Card.new('H', '8'))
      hand.add_card(Card.new('C', '9'))
      hand.add_card(Card.new('S', '10'))
      hand.add_card(Card.new('H', '11'))
      hand.add_card(Card.new('D', '12'))


      expect(PokerRules::evaluate(hand)).to eq('ストレート')
    end

    it 'スリーカード' do
      hand.add_card(Card.new('C', '3'))
      hand.add_card(Card.new('D', '3'))
      hand.add_card(Card.new('H', '3'))
      hand.add_card(Card.new('S', '9'))
      hand.add_card(Card.new('D', '13'))


      expect(PokerRules::evaluate(hand)).to eq('スリーカード')
    end

    it '2ペア' do
      hand.add_card(Card.new('S', '8'))
      hand.add_card(Card.new('C', '8'))
      hand.add_card(Card.new('H', '13'))
      hand.add_card(Card.new('D', '13'))
      hand.add_card(Card.new('H', '2'))


      expect(PokerRules::evaluate(hand)).to eq('2ペア')
    end

    it '1ペア' do
      hand.add_card(Card.new('D', '10'))
      hand.add_card(Card.new('C', '10'))
      hand.add_card(Card.new('S', '3'))
      hand.add_card(Card.new('H', '4'))
      hand.add_card(Card.new('D', '5'))


      expect(PokerRules::evaluate(hand)).to eq('1ペア')
    end

    it 'ハイカード' do
      hand.add_card(Card.new('C', '6'))
      hand.add_card(Card.new('H', '7'))
      hand.add_card(Card.new('D', '10'))
      hand.add_card(Card.new('S', '11'))
      hand.add_card(Card.new('H', '1'))


      expect(PokerRules::evaluate(hand)).to eq('ハイカード')
    end
  end
end
