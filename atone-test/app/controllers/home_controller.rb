require_relative '../services/hand.rb'
require_relative '../services/deck.rb'
require_relative '../services/poker_game.rb'
require_relative '../services/poker_rules.rb'


class HomeController < ApplicationController

  include PokerRules
  def evaluate_hand

    if request.post?
      input_string = params[:hand] # リクエストからカードの文字列を取得
      deck = Deck.new
      hand = Hand.new

      begin
        hand.convert_string_to_hand(input_string,deck)
      rescue => error_message
        @result = error_message
      end

      if @result.nil?

        @result = PokerRules::evaluate(hand)
      end

      render 'evaluate_hand'
    end
  end
end
