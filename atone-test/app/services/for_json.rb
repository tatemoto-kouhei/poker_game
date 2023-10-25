require 'json'
require '/Users/k.tatemoto/rails-project/atone-test/app/services/poker.rb'
require '/Users/k.tatemoto/rails-project/atone-test/app/services/card.rb'

module ForJson

  # アウトプット用メソッド
  def players_info_as_json
    result = []
    errors = []

    @players.each do |player|
      player_info = {
        "card" => player.cards,
        "hand" => player.hand,
        "best" => player.best_hand_flag
      }
      result << player_info

      unless player.error_message.nil?
        error_info = {
          "card" => player.cards,
          "msg" => player.error_message
        }
        errors << error_info
      end
    end

    output = {
      "result" => result
    }

    output["error"] = errors unless errors.empty?
    JSON.generate(output)
  end


  # インプット用メソッド
  def json_to_string_hands(json)
    require 'json'
    data = JSON.parse(json)
    if data.key?('cards') && data['cards'].is_a?(Array)
      data['cards']
    else
      raise ArgumentError, 'Invalid JSON format'
    end
  rescue JSON::ParserError
    raise ArgumentError, 'Invalid JSON format'
  end

end
