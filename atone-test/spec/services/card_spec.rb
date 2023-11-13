require_relative "../../app/services/card.rb"

#カードクラスのテスト
RSpec.describe Card do
  it '存在するスート，ランクの入力に対して適切に初期化されている' do

    card = Card.new('C', '5')

    expect(card.rank).to eq '5'
    expect(card.suit).to eq 'C'
    expect(card.valid?).to be true
  end

  it '存在しないスートの入力に対してエラーが発生する' do

    card = Card.new('R', '5')
    
    expect(card.valid?).to be false
  end

  it '存在しないランクの入力に対してエラーが発生する' do

    card = Card.new('D', '15')
    
    expect(card.valid?).to be false
  end

end


