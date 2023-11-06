class RescueJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue ActionDispatch::ParamsParser::ParseError => _e
      return [
        400, { 'Content-Type' => 'application/json' },
        [{ error: '不正なJSON形式でのリクエストが行われました' }.to_json]
      ]
    end
  end
end
