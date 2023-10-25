require '/Users/k.tatemoto/rails-project/atone-test/app/services/card.rb'

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


