require "../../app/services/poker_rules.rb"  # テスト対象のコードファイルをインポート

describe PokerRules do
  let(:hand) { Hand.new }

  context 'when evaluating poker hands' do
    it 'correctly identifies a Straight Flush' do
      hand.add_card(Card.new('H', '9'))
      hand.add_card(Card.new('H', '8'))
      hand.add_card(Card.new('H', '7'))
      hand.add_card(Card.new('H', '6'))
      hand.add_card(Card.new('H', '5'))

      expect(PokerRules::evaluate(hand)).to eq('ストレートフラッシュ')
    end

    it 'correctly identifies a Four of a Kind' do
      hand.add_card(Card.new('C', '4'))
      hand.add_card(Card.new('D', '4'))
      hand.add_card(Card.new('H', '4'))
      hand.add_card(Card.new('S', '4'))
      hand.add_card(Card.new('D', '7'))

      expect(PokerRules::evaluate(hand)).to eq('フォーカード')
    end

    it 'correctly identifies a Full House' do
      hand.add_card(Card.new('S', '6'))
      hand.add_card(Card.new('H', '6'))
      hand.add_card(Card.new('D', '6'))
      hand.add_card(Card.new('H', '9'))
      hand.add_card(Card.new('C', '9'))

      expect(PokerRules::evaluate(hand)).to eq('フルハウス')
    end

    it 'correctly identifies a Flush' do
      hand.add_card(Card.new('D', '2'))
      hand.add_card(Card.new('D', '8'))
      hand.add_card(Card.new('D', '4'))
      hand.add_card(Card.new('D', '7'))
      hand.add_card(Card.new('D', '13'))

      expect(PokerRules::evaluate(hand)).to eq('フラッシュ')
    end

    it 'correctly identifies a Straight' do
      hand.add_card(Card.new('H', '8'))
      hand.add_card(Card.new('C', '9'))
      hand.add_card(Card.new('S', '10'))
      hand.add_card(Card.new('H', '11'))
      hand.add_card(Card.new('D', '12'))


      expect(PokerRules::evaluate(hand)).to eq('ストレート')
    end

    it 'correctly identifies a Three of a Kind' do
      hand.add_card(Card.new('C', '3'))
      hand.add_card(Card.new('D', '3'))
      hand.add_card(Card.new('H', '3'))
      hand.add_card(Card.new('S', '9'))
      hand.add_card(Card.new('D', '13'))


      expect(PokerRules::evaluate(hand)).to eq('スリーカード')
    end

    it 'correctly identifies Two Pair' do
      hand.add_card(Card.new('S', '8'))
      hand.add_card(Card.new('C', '8'))
      hand.add_card(Card.new('H', '13'))
      hand.add_card(Card.new('D', '13'))
      hand.add_card(Card.new('H', '2'))


      expect(PokerRules::evaluate(hand)).to eq('2ペア')
    end

    it 'correctly identifies One Pair' do
      hand.add_card(Card.new('D', '10'))
      hand.add_card(Card.new('C', '10'))
      hand.add_card(Card.new('S', '3'))
      hand.add_card(Card.new('H', '4'))
      hand.add_card(Card.new('D', '5'))


      expect(PokerRules::evaluate(hand)).to eq('1ペア')
    end

    it 'correctly identifies High Card' do
      hand.add_card(Card.new('C', '6'))
      hand.add_card(Card.new('H', '7'))
      hand.add_card(Card.new('D', '10'))
      hand.add_card(Card.new('S', '11'))
      hand.add_card(Card.new('H', '1'))


      expect(PokerRules::evaluate(hand)).to eq('ハイカード')
    end
  end
end
