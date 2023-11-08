require "../../app/services/hand.rb"
require "pry"

RSpec::Matchers.define :be_same_cards_array do |output_cards|
  match do |input_cards|
    input_cards.each_with_index do |card,index|

       if card!=output_cards[index]
         return
       end 
    end
  end
end

describe Hand do

  describe "#add_card" do
    context 'ハンドインスタンスにカードインスタンスを格納する' do
      it '存在するカードが追加される' do
        hand = Hand.new
        card = Card.new('D', '3')
        hand.add_card(card)
        expect(hand.cards).to include(card)
      end

      it '存在しないカードが追加される際にエラーが発生する' do
        hand = Hand.new
        card = Card.new('P', '9')
        expect { hand.add_card(card) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#convert_string_to_hand' do
    context '適切な文字列の手札でハンドインスタンスを初期化する' do
      it '適切な入力値で初期化する' do
        deck = Deck.new
        hand = Hand.new
        error_message = []
        input_string = 'S13 D3 C2 D11 H2'
        expected_cards = [
          Card.new('S','13'),
          Card.new('D','3'),
          Card.new('C','2'),
          Card.new('D','11'),
          Card.new('H','2')
        ]
        hand.convert_string_to_hand(input_string,deck,error_message)
        expect(hand.cards).to be_same_cards_array(expected_cards)
      end
    end


    context '不正な文字列の手札でハンドインスタンスを初期化しエラーメッセージが格納される' do
      context '一つのエラーを含む入力値で初期化' do

        it '手札の枚数が5枚を超過している' do
          deck = Deck.new
          hand = Hand.new
          error_message = []
          input_string = 'S12 D3 C2 D11 H2 H3'

          hand.convert_string_to_hand(input_string,deck,error_message)
          expect(error_message[0]).to eq("手札の数は5枚である必要があります")
        end

        it '手札の枚数が5枚を不足している' do
          deck = Deck.new
          hand = Hand.new
          error_message = []
          input_string = 'S12 D3 C2 D11'

          hand.convert_string_to_hand(input_string,deck,error_message)
          expect(error_message[0]).to eq("手札の数は5枚である必要があります")
        end

      end

      context '複数のエラーを含む入力値で初期化する' do
        it '不正なカード，枚数超過を含む入力値で初期化する' do
          deck = Deck.new
          hand = Hand.new
          error_message = []
          input_string = 'F13 D3 C2 D11 H2 D2'

          hand.convert_string_to_hand(input_string,deck,error_message)
          expect(error_message[0]).to eq("無効なカードが入力されました: F13")
          expect(error_message[1]).to eq("手札の数は5枚である必要があります")
          

        end
      end
    end
  end
end
