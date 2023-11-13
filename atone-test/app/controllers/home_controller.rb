
class HomeController < ApplicationController

  include PokerRules
  def evaluate_hand

    if request.post?
      @input_string = params[:hand] # リクエストからカードの文字列を取得
      deck = Deck.new
      hand = Hand.new
      error_message = []

      hand.convert_string_to_hand(@input_string,deck,error_message)

      unless error_message.empty?
        @result = error_message.join(",  ")
      else

        poker_hand = PokerRules::evaluate(hand)
        @result = "入力された手札は" + poker_hand + "です"
      end

      render 'evaluate_hand'
    end
  end
end
