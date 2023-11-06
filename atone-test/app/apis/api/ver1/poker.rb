require 'json'
require 'pry'
require_relative '../../../services/poker_game.rb'
require_relative '../../../services/for_json.rb'



module API	
  module Ver1
    class Poker < Grape::API
      format :json
      resource :poker do

        post do
          request_body = JSON.parse(request.body.read)
          string_hands = request_body["cards"]
          #ポーカーゲームの生成・初期化を行う
          game = PokerGame.new(string_hands)

          game.evaluate_best_hand_player

          #Player情報のJSON形式のアウトプット処理を呼び出す
          ForJson::players_info_as_json(game)

        end
      end
    end
  end
end

