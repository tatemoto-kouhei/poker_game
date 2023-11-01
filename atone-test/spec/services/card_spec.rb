require "../../app/services/card.rb"

#カードクラスのテスト
RSpec.describe 'test_class' do
  it 'Valid input' do
    card = Card.new(rank: 5, suit: :C)
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


