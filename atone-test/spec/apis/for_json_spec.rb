require 'json'
require '/Users/k.tatemoto/rails-project/atone-test/app/services/poker.rb'
require '/Users/k.tatemoto/rails-project/atone-test/app/services/card.rb'
require '/Users/k.tatemoto/rails-project/atone-test/app/services/player.rb'
require '/Users/k.tatemoto/rails-project/atone-test/app/services/for_json.rb'

RSpec.describe PokerGame do
  describe '#players_info_as_json' do
    it 'generates the correct JSON output' do
      string_hands = ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "C13 D12 C11 H8 H7"]
      poker_game = PokerGame.new(string_hands)

      # Evaluate hands

      poker_game.evaluate_best_hand_player

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

      expect(players_info_as_json(poker_game)).to eq(expected_json)
    end
  end
end

require 'json'

RSpec.describe PokerGame do
  describe '#players_info_as_json' do
    context 'with invalid input' do
      it 'generates the correct JSON output for invalid input' do
        string_hands = ["H1 H13 H12 H11 H10", "H9 C9 S9 H2 C2", "Invalid Hand"]
        poker_game = PokerGame.new(string_hands)

        # Evaluate hands

        poker_game.evaluate_best_hand_player

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
              card: "Invalid Hand",
              hand: "Invalid Input",
              best: false
            }
          ]
        }.to_json

        expect(players_info_as_json(poker_game)).to eq(expected_json)
      end
    end
  end
end
