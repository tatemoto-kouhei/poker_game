
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

      @cards << card
      raise ArgumentError, "無効なカードが入力されました: #{card}"
    end

    @cards << card
  end

  # ハンド内のカードを文字列として表現します。
  def to_s
    @cards.map { |card| card.to_s }.join(' ')
  end

  # 文字列をハンドに変換するメソッド
  def convert_string_to_hand(input_string, deck,error_message)
    input_string.split(/[[:blank:]]+/).each do |card_string|
      suit = card_string[0]
      rank = card_string[1..-1]

      card = Card.new(suit, rank)

      begin
        # ハンドにカードを追加
        add_card(card)
        # デッキにカードを追加
        deck.add_card(card)
     rescue => e
        error_message << e.message
      end

      # begin
      #   # デッキにカードを追加
      #   deck.add_card(card)
      # rescue ArgumentError => e
      #   error_message << e.message
      # end
    end

    begin

      is_card_count_valid
    rescue ArgumentError => e
      error_message << e.message
    end

  end

  #カードの枚数がルールに則っているか確認する　
  def is_card_count_valid
    poker_hand_size = 5
    unless @cards.size == poker_hand_size
      raise ArgumentError, "手札の数は5枚である必要があります"
    end
  end
end


