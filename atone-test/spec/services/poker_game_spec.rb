require_relative '../../app/services/poker_game.rb'
require 'pry'


describe PokerGame do
  context "with valid input" do
    it "determines the best hand correctly" do
      string_hands = ['H1 D1 S1 S11 S4', 'H2 D11 S3 S5 S12', 'C1 C3 C11 C2 C4']

      poker_game = PokerGame.new(string_hands)
      poker_game.evaluate_best_hand_player

      # 3つの札の内、3番目の手札が最も強い役を持つ
      expect(poker_game.players[0].best_hand_flag).to be false
      expect(poker_game.players[1].best_hand_flag).to be false
      expect(poker_game.players[2].best_hand_flag).to be true
    end
  end

  context "with invalid input" do
    it "raises an error and sets an error message for invalid cards" do
      string_hands = ['H1 D1 X1 S11 S4']  # 'X'というスートが存在しない

      poker_game = PokerGame.new(string_hands)

      expect(poker_game.players[0].error_message).to eq("無効なカードが入力されました: X1")
    end

    it "raises an error and sets an error message for improperly formatted input" do
      string_hands = ['H1 D1 S7 S11 S9', 'H2 D3 S4 S5 S6', 'C1 C3 C11 C2']  # 手札の数が合わない

      poker_game = PokerGame.new(string_hands)
      poker_game.evaluate_best_hand_player

      # 3つの手札の内、3番目の手札が不正な入力でエラーメッセージが設定される
      expect(poker_game.players[0].best_hand_flag).to be false
      expect(poker_game.players[1].best_hand_flag).to be true
      expect(poker_game.players[2].best_hand_flag).to be false
      expect(poker_game.players[2].error_message).to eq("手札の数は5枚である必要があります")
    end
  end
end
