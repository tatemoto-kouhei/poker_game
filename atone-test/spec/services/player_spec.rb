require_relative '../../app/services/deck.rb'
require_relative '../../app/services/card.rb'
require_relative '../../app/services/hand.rb'
require_relative '../../app/services/player.rb'
require 'pry'



RSpec.describe Player, type: :model do
  context 'with valid input' do
    it 'initializes a player with valid cards' do
      deck = Deck.new
      string_hands = 'H1 H13 H12 H11 H10'
      player = Player.new(string_hands, deck)

      expect(player).to be_a(Player)
      expect(player.hand).to be_a(Hand)
      expect(player.cards).to eq(string_hands)
      expect(player.best_hand_flag).to eq(false)
      expect(player.poker_hand).to be_nil
      expect(player.poker_hand_rank).to eq(0)
      expect(player.error_message).to be_nil
    end
  end

  context 'with invalid input' do
    it 'initializes a player with invalid cards and sets an error message' do
      deck = Deck.new
      invalid_string_hands = 'H1 H13 H12 H11 X10'
      player = Player.new(invalid_string_hands, deck)

      expect(player).to be_a(Player)
      expect(player.cards).to eq(invalid_string_hands)
      expect(player.hand).to be_nil
      expect(player.poker_hand).to be_nil
      expect(player.poker_hand_rank).to eq(0)
      expect(player.error_message).not_to be_nil
      expect(player.error_message).to be_a(String)
    end
  end
end
