require '/Users/k.tatemoto/rails-project/atone-test/app/controllers/api_controller.rb'
require '/Users/k.tatemoto/rails-project/atone-test/app/controllers/application_controller.rb'
require 'rails_helper'


RSpec.describe ApiController, type: :controller do
  it 'returns the correct poker results' do
    # 正常なJSONデータの例
    valid_json = {
      "card": [
        "H1 H13 H12 H11 H10",
        "H9 C9 S9 H2 C2",
        "C13 D12 C11 H8 H7"
      ]
    }

    expected_json = {
      result: [
          {
            card: "H1 H13 H12 H11 H10",
            hand: "Straight Flush",
            best: true
          },
          {
            card: "H9 C9 S9 H2 C2",
            hand: "Full House",
            best: false
          },
          {
            card: "C13 D12 C11 H8 H7",
            hand: "High Card",
            best: false
          }
        ]
      }.to_json



    post :play_poker, body: valid_json.to_json, format: :json

    expect(response).to have_http_status(:success)
    response_body = JSON.parse(response.body)

    # 正常なレスポンスの検証（具体的な検証ロジックを追加してください）
    expect(response_body["result"]).not_to be_nil
      # expect(players_info_as_json(poker_game)).to eq(expected_json)


    # 他の期待値を追加
    # 他の期待値を追加

    # 不正なJSONデータの例
    invalid_json = {
      "invalid_key": "invalid_data"
    }

    post :play_poker, body: invalid_json.to_json, format: :json

    expect(response).to have_http_status(:unprocessable_entity)
    response_body = JSON.parse(response.body)
    expect(response_body["error"]).to eq('Invalid JSON data')
  end
end
