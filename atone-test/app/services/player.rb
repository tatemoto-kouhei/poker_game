require '/Users/k.tatemoto/rails-project/atone-test/app/services/card.rb'


# プレイヤークラス（API用）
class Player
  attr_reader :cards
  attr_reader :hand
  attr_accessor :best_hand_flag
  attr_accessor :poker_hand
  attr_accessor :poker_hand_rank
  attr_accessor :error_message

  def initialize(string_hands, deck)
    @hand = Hand.new
    @cards = string_hands
    @best_hand_flag = false
    @poker_hand = nil
    @poker_hand_rank = 0
    @error_message = nil  # エラーメッセージを初期化
    hand.convert_string_to_hand(@cards, deck)  # input_string -> @cards と修正
  rescue StandardError => e
    @error_message = e.message  # エラーメッセージを設定
  end
end
