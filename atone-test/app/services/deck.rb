require_relative 'card.rb'

# デッキクラス
class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    if cards.any? { |added_card| added_card.suit == card.suit && added_card.rank == card.rank }
      raise ArgumentError, "カードが重複しています: #{card}"
    else
      @cards << card
    end
  end
end

