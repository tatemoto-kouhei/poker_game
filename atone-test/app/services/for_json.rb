require 'json'
require_relative 'poker_game.rb'
require_relative 'player.rb'

module ForJson

  # アウトプット用メソッド
  def players_info_as_json(game)
    players = game.players
    output = []
    result = []
    errors = []

    players.each do |player|
      unless player.error_message.nil?
        error_info = {
          "card" => player.cards,
          "msg" => player.error_message
        }
        errors << error_info
      else
        player_info = {
          "card" => player.cards,
          "hand" => player.poker_hand,
          "best" => player.best_hand_flag
        }
        result << player_info

      end
    end

    if errors.empty?

      {
        result: result
      }
    else
      {
        result: result,
        error: errors
      }
    end
  end

  module_function :players_info_as_json
  public :players_info_as_json

end
