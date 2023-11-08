require 'json'
require 'grape'
require 'rails_helper'
require_relative '../../../../app/apis/api/ver1/poker.rb'

RSpec.describe API::Ver1::Poker, type: :request do
  describe 'POST /api/poker' do
    context '有効な入力の場合' do
      # let(:valid_input) do
      #   {
      #     "cards": [
      #       "H1 H13 H12 H11 H10",
      #       "H9 C9 S9 H2 C2",
      #       "C13 D12 C11 H8 H7"
      #     ]
      #   }
      # end
      #
      valid_input = 
      it 'プレイヤー情報を含むJSONレスポンスを返す' do
        # 有効な入力でPOSTリクエストを作成
        post '/api/poker', { "cards": [ "H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2",  "C13 D12 C11 H8 H7" ] }, as: :json

        # 正常なレスポンスを期待
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)

        # JSONレスポンスの構造を検証
        expect(json_response).to have_key('result')
        expect(json_response['error']).to be_nil

        # プレイヤー情報を検証
        result = json_response['result']
        expect(result).to be_an(Array)
        expect(result.length).to eq(3)

        player_info = result[0]
        expect(player_info).to have_key('card')
        expect(player_info['hand']).to be_a(String)
        expect(player_info['best']).to be_in([true, false])
      end
    end

    context '無効な入力の場合' do
      let(:invalid_input) do
        {
          cards: [
            "H1 H13 H12 H11 H10",
            "H9 C9 S9 H2 C2",
            "Invalid Card Data"
          ]
        }
      end

      it 'エラー情報を含むJSONレスポンスを返す' do
        # 無効な入力でPOSTリクエストを作成
        post '/api/poker', json: invalid_input.to_json, headers: { 'Content-Type' => 'application/json' }

        # Unprocessable Entity（422）のレスポンスを期待
        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)

        # JSONレスポンスの構造を検証
        expect(json_response).to have_key('result')
        expect(json_response).to have_key('error')

        # プレイヤー情報とエラー情報を検証
        result = json_response['result']
        error = json_response['error']

        expect(result).to be_an(Array)
        expect(result.length).to eq(2)

        expect(error).to be_an(Array)
        expect(error.length).to eq(1)

        player_info = result[0]
        error_info = error[0]

        expect(player_info).to have_key('card')
        expect(player_info['hand']).to be_a(String)
        expect(player_info['best']).to be_in([true, false])

        expect(error_info).to have_key('card')
        expect(error_info).to have_key('msg')
        expect(error_info['msg']).to be_a(String)
      end
    end
  end
end
