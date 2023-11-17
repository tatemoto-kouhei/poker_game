require 'rails_helper'


RSpec.describe "Player" do
  context '適切な入力' do
    it '適切な入力に対してそれぞれのインスタンス変数が適切に初期化されている' do
      deck = Deck.new
      string_hands = 'H1 H13 H12 H11 H10'
      player = Player.new(string_hands, deck)

      expect(player).to be_a(Player)
      expect(player.hand).to be_a(Hand)
      expect(player.cards).to eq(string_hands)
      expect(player.best_hand_flag).to eq(false)
      expect(player.poker_hand).to be_nil
      expect(player.poker_hand_rank).to eq(0)
      expect(player.error_message).to be_empty
    end
  end

  context '不正な入力' do
    it '不正な入力に対して適切なエラーメッセージが格納されている' do
      deck = Deck.new
      invalid_string_hands = 'H1 H13 H12 H11 X10'
      player = Player.new(invalid_string_hands, deck)

      expect(player).to be_a(Player)
      expect(player.cards).to eq(invalid_string_hands)
      expect(player.hand).to be_nil
      expect(player.poker_hand).to be_nil
      expect(player.poker_hand_rank).to eq(0)
      expect(player.error_message).not_to be_empty
      expect(player.error_message[0]).to be_a(String)
    end
  end

  context '一つの手札の入力に対して複数エラーが発生した際のエラーハンドリング' do
    it '一つの手札に対して複数のエラーが発生した際にerror_messagesにエラーが二つ格納されている' do
      deck = Deck.new
      multiple_invalid_string_hands = "H1 J2 D1 D23 S4"
      player = Player.new(multiple_invalid_string_hands,deck)

      expect(player).to be_a(Player)
      expect(player.cards).to eq(multiple_invalid_string_hands)
      expect(player.hand).to be_nil
      expect(player.poker_hand).to be_nil
      expect(player.poker_hand_rank).to eq(0)
      expect(player.error_message).not_to be_empty
      expect(player.error_message[0]).to be_a(String)
      expect(player.error_message[1]).to be_a(String)
    end
  end
end
