require '/Users/k.tatemoto/rails-project/atone-test/app/services/hand_class.rb'

require '/Users/k.tatemoto/rails-project/atone-test/app/services/poker_ranker.rb'

class HomeController < ApplicationController

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

        @result = hand.evaluate
      end

      render 'evaluate_hand'
    end
  end
  
  def play_poker(json)
    #JSONファイルと文字列状態の手札の配列に分ける
    string_cards = json_to_string_hands(:home)
    
    #ポーカーゲームの生成・初期化を行う
    game = PokerGame.new(string_cards)
    game.evaluate_best_hand_player

    #Player情報のJSON形式のアウトプット処理を呼び出す
    
    result = players_info_as_json(game)

    #APIに結果を返す処理
    render plain: result
  end
    
end
