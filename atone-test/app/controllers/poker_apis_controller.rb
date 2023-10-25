require './application_controller.rb'


class PokerApisController < ApplicationController
  protect_from_forgery

  def play_poker
    #JSONファイルと文字列状態の手札の配列に分ける
    begin
      request_body = JSON.parse(request.body.read)
      string_hands = request.body['card']
    rescue => e
      render json: {error: 'Invalid JSON data'},status: :unprocessable_entity
    end

    #ポーカーゲームの生成・初期化を行う
    game = PokerGame.new(string_cards)
    game.evaluate_best_hand_player

    #Player情報のJSON形式のアウトプット処理を呼び出す
    result = player_info_as_json(game)

    #APIに結果を返す処理
    render json: { result: result }
  end

end
