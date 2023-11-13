require 'json'


module ForJson
  # アウトプット用メソッド
  def players_info_as_json(game)
    players = game.players
    output = []
    result = []
    errors = []

    players.each do |player|
      unless player.error_message.empty?
        player.error_message.each do |error|
          error_info = {
            "card" => player.cards,
            "msg" => error
          }
          errors << error_info
        end
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
    elsif result.empty?
      {
        error: errors
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
