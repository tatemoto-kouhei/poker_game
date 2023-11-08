require 'pry'
require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'poker_rules.rb'
# 手札が複数ある場合にどの手札が一番強いかを判定する
class PokerGame 
  attr_reader :players
  include PokerRules

  def initialize(string_hands)
    @players = []
    @best_hand = nil
    # 役のランクを定義します．役の強いほどランクが高くなります．
    @hand_ranker = {
      'ハイカード' => 1,
      '1ペア' => 2,
      '2ペア' => 3,
      'スリーカード' => 4,
      'ストレート' => 5,
      'フラッシュ' => 6,
      'フルハウス' => 7,
      'フォーカード' => 8,
      'ストレートフラッシュ' => 9
    }

    deck = Deck.new

    string_hands.each do |string_hand|
      @players << Player.new(string_hand, deck)
    end
  end

  #手札に対する役を判定する
  def find_best_hand
    @players.each do |player|
      if player.error_message.empty?
        player.poker_hand = PokerRules::evaluate(player.hand)
        if @best_hand.nil? || @hand_ranker[player.poker_hand] >= @hand_ranker[@best_hand]
          @best_hand = player.poker_hand
        end
      end
    end
  end

  #複数の手札の中から最も強い役を判定し
  def evaluate_best_hand_player
    find_best_hand
    @players.each do |player|
      if player.poker_hand == @best_hand
        player.best_hand_flag = true
      end
    end
  end
end


