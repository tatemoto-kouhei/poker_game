require 'json'
require 'pry'
require_relative '../../app/services/poker_game.rb'
require_relative '../../app/services/player.rb'
require_relative '../../app/services/for_json.rb'



RSpec.describe ForJson do
  describe 'players_info_as_json' do
    it 'generates JSON output for players with no errors' do
      # テスト用のポーカーゲームを生成
      game = PokerGame.new(['H1 D1 S1 S11 S4', 'H2 D11 S3 S5 S12'])
      game.evaluate_best_hand_player

      # JSONアウトプットを生成
      json_output = ForJson.players_info_as_json(game)

      expect(json_output).to have_key(:result)
      expect(json_output).not_to have_key(:error)  # :errorキーが存在しないことを確認

      result = json_output[:result]
      expect(result).to be_a(Array)
      expect(result.length).to eq(2)

      player_info = result[0]
      expect(player_info).to have_key("card")
      expect(player_info).to have_key("hand")
      expect(player_info).to have_key("best")
      expect(player_info["hand"]).to be_a(String)
      expect(player_info["best"]).to be(true)
    end

    it 'generates JSON output for players with errors' do
      # エラーを含むテスト用のポーカーゲームを生成
      game = PokerGame.new(['H1 D1 S1 S11 X4', 'H2 D11 S3 S5 S12'])
      game.evaluate_best_hand_player

      # JSONアウトプットを生成
      json_output = ForJson.players_info_as_json(game)

      expect(json_output).to have_key(:result)
      expect(json_output).to have_key(:error)

      result = json_output[:result]
      errors = json_output[:error]

      expect(result).to be_a(Array)
      expect(result.length).to eq(1)

      expect(errors).to be_a(Array)
      expect(errors.length).to eq(1)

      player_info = result[0]
      error_info = errors[0]

      expect(player_info).to have_key("card")
      expect(player_info).to have_key("hand")
      expect(player_info).to have_key("best")
      expect(player_info["hand"]).to be_a(String)
      expect(player_info["best"]).to be(true)

      expect(error_info).to have_key("card")
      expect(error_info).to have_key("msg")
      expect(error_info["msg"]).to be_a(String)
    end
  end
end

