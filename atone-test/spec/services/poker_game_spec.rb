require 'rails_helper'

describe "PokerGame" do

  context "適切な入力" do
    it "複数の手札から最も強い手札を持つプレイヤーのbest_hand_flagをtrueにする" do
      string_hands = ['H1 D1 S1 S11 S4', 'H2 D11 S3 S5 S12', 'C1 C3 C11 C2 C4']

      poker_game = PokerGame.new(string_hands)
      poker_game.evaluate_best_hand_player

      # 3つの札の内、3番目の手札が最も強い役を持つ
      expect(poker_game.players[0].best_hand_flag).to be false
      expect(poker_game.players[1].best_hand_flag).to be false
      expect(poker_game.players[2].best_hand_flag).to be true
    end
  end

  context "不正な入力" do
    it "不正な入力を含む複数の入力に対して適切な手札の評価，不正な入力に対するエラーメッセージの格納" do
      string_hands = ['H1 D1 S7 S11 S9', 'H2 D3 S4 S5 S6', 'C1 C3 C11 C2']  # 手札の数が合わない

      poker_game = PokerGame.new(string_hands)
      poker_game.evaluate_best_hand_player

      # 3つの手札の内、3番目の手札が不正な入力でエラーメッセージが設定される
      expect(poker_game.players[0].best_hand_flag).to be false
      expect(poker_game.players[1].best_hand_flag).to be true
      expect(poker_game.players[2].best_hand_flag).to be false
      expect(poker_game.players[2].error_message[0]).to eq("手札の数は5枚である必要があります")
    end
  end
end
