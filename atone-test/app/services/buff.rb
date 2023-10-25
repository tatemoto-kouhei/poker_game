require 'pry'
require 'json'

def convert_json_to_hands(json_data)
  begin
    parsed_data = JSON.parse(json_data)
    if parsed_data.key?('cards') && parsed_data['cards'].is_a?(Array)
      return parsed_data['cards']
    else
      raise "Invalid JSON structure: 'cards' field is missing or not an array."
    end
  rescue JSON::ParserError
    raise "Invalid JSON format."
  end
end

def players_info_as_json(poker_game)
  players_info = poker_game.players.map do |player|
      {
        "cards" => player.hand.to_s,
        "best_hand_flag" => player.best_hand_flag,
        "best" => player.best_hand_flag
      }
    end
    JSON.generate(players_info)
end

# ポーカールールを判定するクラス
class PokerRules
  def initialize(hand)
    @hand = hand
    @ranks = hand.cards.map { |card| card.rank }
    @suits = hand.cards.map { |card| card.suit }
  end

  def evaluate
    return 'Straight Flush' if straight_flush?
    return 'Four of a Kind' if four_of_a_kind?
    return 'Full House' if full_house?
    return 'Flush' if flush?
    return 'Straight' if straight?
    return 'Three of a Kind' if three_of_a_kind?
    return 'Two Pair' if two_pair?
    return 'One Pair' if one_pair?
    'High Card'
  end

  private

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
end

# 手札が複数ある場合にどの手札が一番強いかを判定する
class PokerGame
  attr_reader :players

  def initialize(string_hands)
    @players = []
    @best_hand = nil
    # 役のランクを定義します．役の強いほどランクが高くなります．
    @hand_ranker = {
      'High Card' => 1,
      'One Pair' => 2,
      'Two Pair' => 3,
      'Three of a Kind' => 4,
      'Straight' => 5,
      'Flush' => 6,
      'Full House' => 7,
      'Four of a Kind' => 8,
      'Straight Flush' => 9
    }

    deck = Deck.new

    string_hands.each do |string_hand|
      @players << Player.new(string_hand, deck)
    end
  end

  def evaluate(hand)
    poker_rules = PokerRules.new(hand)
    poker_rules.evaluate
  end

  def find_best_hand
    @players.each do |player|
      if player.error_message.nil?
        player.poker_hand = evaluate(player.hand)
        if @best_hand.nil? || @hand_ranker[player.poker_hand] >= @hand_ranker[@best_hand]
          @best_hand = player.poker_hand
        end
      end
    end
  end

  def evaluate_best_hand_player
    find_best_hand
    @players.each do |player|
      if player.poker_hand == @best_hand
        player.best_hand_flag = true
      end
    end
  end
end

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
