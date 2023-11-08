require 'rails_helper'
require_relative '../../app/controllers/home_controller.rb'

RSpec.describe HomeController, type: :controller do
  describe 'POST #evaluate_hand' do
    context '有効な入力の場合' do
      it 'ポーカーハンドの結果を代入する' do
        post :evaluate_hand, { hand: 'H1 H13 H12 H11 H10' }

        expect(assigns(:result)).to eq('入力された手札はストレートフラッシュです')
      end

      it 'evaluate_hand テンプレートをレンダリングする' do
        post :evaluate_hand, { hand: 'H1 H13 H12 H11 H10' }

        expect(response).to render_template('evaluate_hand')
      end
    end

    context '無効な入力の場合' do
      it 'エラーメッセージを代入する' do
        post :evaluate_hand, { hand: 'S1 S2 S3 S4 S5 S6' }

        expect(assigns(:result)).to be_an(Array)
        expect(assigns(:result)).to be(['手札の数は5枚である必要があります'])
      end

      it 'evaluate_hand テンプレートをレンダリングする' do
        post :evaluate_hand, { hand: 'Invalid Card Data' }

        expect(response).to render_template('evaluate_hand')
      end
    end
  end
end
