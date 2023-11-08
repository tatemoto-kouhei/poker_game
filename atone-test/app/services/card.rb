require 'pry'

# カードクラス
class Card
  attr_reader :suit, :rank

  # カードを初期化します。
  # suit: カードのスート (S, D, C, H)
  # rank: カードのランク (2, 3, 4, ..., 13, 1)
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  # カードが正当かどうかを判定します。
  def valid?
    valid_suits = %w[S D C H]
    valid_ranks = %w[2 3 4 5 6 7 8 9 10 11 12 13 1]

    # カードのスートとランクが有効なものであるかを確認
    valid_suits.include?(@suit) && valid_ranks.include?(@rank)
  end

  # カードを文字列として表現します。
  def to_s
    "#{suit}#{rank}"
  end

  def !=(other)
    self.suit != other.suit || self.rank != other.rank
  end
end

