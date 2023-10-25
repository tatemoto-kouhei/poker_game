require "/Users/k.tatemoto/rails-project/atone-test/app/services/poker_ranker.rb"  # テスト対象のコードファイルをインポート

describe PokerRules do
  let(:hand) { Hand.new }

  context 'when evaluating poker hands' do
    it 'correctly identifies a Straight Flush' do
      hand.add_card(Card.new('H', '9'))
      hand.add_card(Card.new('H', '8'))
      hand.add_card(Card.new('H', '7'))
      hand.add_card(Card.new('H', '6'))
      hand.add_card(Card.new('H', '5'))

      poker_rules = PokerRules.new(hand)
      expect(poker_rules.evaluate).to eq('Straight Flush')
    end

    it 'correctly identifies a Four of a Kind' do
      hand.add_card(Card.new('C', '4'))
      hand.add_card(Card.new('D', '4'))
      hand.add_card(Card.new('H', '4'))
      hand.add_card(Card.new('S', '4'))
      hand.add_card(Card.new('D', '7'))

      poker_rules = PokerRules.new(hand)
      expect(poker_rules.evaluate).to eq('Four of a Kind')
    end

    it 'correctly identifies a Full House' do
      hand.add_card(Card.new('S', '6'))
      hand.add_card(Card.new('H', '6'))
      hand.add_card(Card.new('D', '6'))
      hand.add_card(Card.new('H', '9'))
      hand.add_card(Card.new('C', '9'))

      poker_rules = PokerRules.new(hand)
      expect(poker_rules.evaluate).to eq('Full House')
    end

    it 'correctly identifies a Flush' do
      hand.add_card(Card.new('D', '2'))
      hand.add_card(Card.new('D', '8'))
      hand.add_card(Card.new('D', '4'))
      hand.add_card(Card.new('D', '7'))
      hand.add_card(Card.new('D', '13'))

      poker_rules = PokerRules.new(hand)
      expect(poker_rules.evaluate).to eq('Flush')
    end

    it 'correctly identifies a Straight' do
      hand.add_card(Card.new('H', '8'))
      hand.add_card(Card.new('C', '9'))
      hand.add_card(Card.new('S', '10'))
      hand.add_card(Card.new('H', '11'))
      hand.add_card(Card.new('D', '12'))

      poker_rules = PokerRules.new(hand)
      expect(poker_rules.evaluate).to eq('Straight')
    end

    it 'correctly identifies a Three of a Kind' do
      hand.add_card(Card.new('C', '3'))
      hand.add_card(Card.new('D', '3'))
      hand.add_card(Card.new('H', '3'))
      hand.add_card(Card.new('S', '9'))
      hand.add_card(Card.new('D', '13'))

      poker_rules = PokerRules.new(hand)
      expect(poker_rules.evaluate).to eq('Three of a Kind')
    end

    it 'correctly identifies Two Pair' do
      hand.add_card(Card.new('S', '8'))
      hand.add_card(Card.new('C', '8'))
      hand.add_card(Card.new('H', '13'))
      hand.add_card(Card.new('D', '13'))
      hand.add_card(Card.new('H', '2'))

      poker_rules = PokerRules.new(hand)
      expect(poker_rules.evaluate).to eq('Two Pair')
    end

    it 'correctly identifies One Pair' do
      hand.add_card(Card.new('D', '10'))
      hand.add_card(Card.new('C', '10'))
      hand.add_card(Card.new('S', '3'))
      hand.add_card(Card.new('H', '4'))
      hand.add_card(Card.new('D', '5'))

      poker_rules = PokerRules.new(hand)
      expect(poker_rules.evaluate).to eq('One Pair')
    end

    it 'correctly identifies High Card' do
      hand.add_card(Card.new('C', '6'))
      hand.add_card(Card.new('H', '7'))
      hand.add_card(Card.new('D', '10'))
      hand.add_card(Card.new('S', '11'))
      hand.add_card(Card.new('H', '1'))

      poker_rules = PokerRules.new(hand)
      expect(poker_rules.evaluate).to eq('High Card')
    end
  end
end
