require '/Users/k.tatemoto/rails-project/atone-test/app/services/hand_class.rb'
require '/Users/k.tatemoto/rails-project/atone-test/app/services/poker_ranker.rb'



class ApiController < ApplicationController

  def play_poker
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
