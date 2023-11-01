require_relative 'hand.rb'
require_relative 'card.rb'

# ポーカーの役を判定するクラス
module PokerRules

  def evaluate(hand)
    @hand = hand
    @ranks = hand.cards.map { |card| card.rank }
    @suits = hand.cards.map { |card| card.suit }

    return 'ストレートフラッシュ' if straight_flush?
    return 'フォーカード' if four_of_a_kind?
    return 'フルハウス' if full_house?
    return 'フラッシュ' if flush?
    return 'ストレート' if straight?
    return 'スリーカード' if three_of_a_kind?
    return '2ペア' if two_pair?
    return '1ペア' if one_pair?
    'ハイカード'
  end
  

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    rank_count = @ranks.group_by { |rank| rank }.transform_values(&:count)
    rank_count.values.include?(4)
  end

  def full_house?
    rank_count = @ranks.group_by { |rank| rank }.transform_values(&:count)
    rank_count.values.sort == [2, 3]
  end

  def flush?
    @suits.uniq.size == 1
  end

  def straight?
    sorted_ranks = @ranks.map(&:to_i).sort

    return true if sorted_ranks == [1,10,11,12,13]
    (1..4).all? { |i| sorted_ranks[i] == sorted_ranks[i - 1] + 1 }
  end

  def three_of_a_kind?
    rank_count = @ranks.group_by { |rank| rank }.transform_values(&:count)
    rank_count.values.include?(3)
  end

  def two_pair?
    rank_count = @ranks.group_by { |rank| rank }.transform_values(&:count)
    rank_count.values.count(2) == 2
  end

  def one_pair?
    rank_count = @ranks.group_by { |rank| rank }.transform_values(&:count)
    rank_count.values.include?(2)
  end


  module_function :evaluate
  module_function :straight_flush?
  module_function :four_of_a_kind?
  module_function :full_house?
  module_function :flush?
  module_function :straight?
  module_function :three_of_a_kind?
  module_function :two_pair?
  module_function :one_pair?
end


