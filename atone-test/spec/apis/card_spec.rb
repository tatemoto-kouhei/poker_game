require "/Users/k.tatemoto/rails-project/atone-test/app/services/card_class.rb"

#カードクラスのテスト
RSpec.describe 'test_class' do
  it 'Valid input' do
    card = Card.new(rank: 5,suit: 'C')
    expect(card.rank).to eq 5
    expect(card.suit).to eq 'C'
  end

  it 'invalid suit' do
    expect{Card.new(rank: 5, suit: :R)}.to raise_error(ArgumentError)
  end
  it 'invalid rank' do
    expect{Card.new(rank: 14, suit: :D)}.to raise_error(ArgumentError)
  end

end


#ハンドクラスのテスト
RSpec.describe 'hand_test' do

  #正常なインプットのテスト
  describe 'valid input' do
    it 'valid_input' do
      deck = Deck.new
      string_cards = 'H1 D3 D4 D5 S1'
      hand = Hand.new(string_cards,deck)

      expect(hand.cards[0].suit).to eq 'H' 

      expect(hand.cards[0].rank).to eq 1 

      expect(hand.cards[4].suit).to eq 'S' 

      expect(hand.cards[4].rank).to eq 1 
    end
  end
  #不適切なインプットのテスト
  describe 'invalid input' do
    #存在しないカードが入力されている
    it 'invalid card' do
      string_cards = 'H1 D3 D4 D5 S31'
      deck = Deck.new
      expect{hand = Hand.new(string_cards,deck)}.to raise_error(ArgumentError)
    end

    #カードクラスに格納されたカードが既にインプットされている
    it 'input_card_duplicated' do
      string_cards = 'H1 D3 D4 D5 H1'
      deck = Deck.new
      expect{hand = Hand.new(string_cards,deck)}.to raise_error(ArgumentError)

      expect()
    end

    #手札の枚数が5枚でない
    # it 'Invalid card_count' do
    #   string_cards = 'H1 D3 D4 D5 S1'
    #   hand = Hand.new(string_cards)
    # end


  end
end
