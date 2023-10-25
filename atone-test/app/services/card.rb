require '/Users/k.tatemoto/rails-project/atone-test/app/services/poker.rb'


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
end

# ハンドクラス
class Hand
  attr_reader :cards

  # ハンドを初期化します。
  def initialize
    @cards = []
  end

  # カードをハンドに追加しますが、正当なカードのみが追加されます。
  # card: 追加するカード
  def add_card(card)
    # カードの要素が正当でない場合エラー
    unless card.valid?
      raise ArgumentError, "Invalid card: #{card}"
    end

    @cards << card
  end

  # ハンド内のカードを文字列として表現します。
  def to_s
    @cards.map { |card| card.to_s }.join(' ')
  end

  # 文字列をハンドに変換するメソッド
  def convert_string_to_hand(input_string, deck)
    input_string.split.each do |card_string|
      suit = card_string[0]
      rank = card_string[1..-1]
      card = Card.new(suit, rank)

      # ハンドにカードを追加
      add_card(card)

      # デッキにカードを追加
      deck.add_card(card)
    end
    is_card_count_valid
  end

  def is_card_count_valid
    poker_hand_size = 5
    unless @cards.size == poker_hand_size
      raise ArgumentError, "手札の数は5枚である必要があります"
    end
  end

  # 役を判定するための役割を持つクラスを作成し、評価メソッドを呼び出す
  def evaluate
    poker_rules = PokerRules.new(self)
    poker_rules.evaluate
  end
end

# デッキクラス
class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    if @cards.include?(card)
      raise ArgumentError, "Duplicated card: #{card}"
    else
      @cards << card
    end
  end
end

