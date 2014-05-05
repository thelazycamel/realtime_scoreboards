module RealtimeScoreboards

  class Listener
    include Vertx

    attr_reader :server, :route_matcher, :port, :host

    def initialize(config = {})
      @server = HttpServer.new
      @route_matcher = RouteMatcher.new
      @host = config[:host]
      @port = config[:port]
    end

    def listen
      route_matcher.post("/scoreboards/:sportid") do |req|
        sport_id = req.params['sportid']
        req.body_handler do |body|
          load_scoreboard(sport_id, body.to_s).push
          req.response.status_code = 200
          req.response.end
        end
      end
      puts "server started and listening on #{host}:#{port}"
      server.request_handler(route_matcher).listen(port, host)
    end

    private

    def load_scoreboard(sport_id, json_data)
      RealtimeScoreboards::Scoreboard.new_scoreboard_instance(sport_id, json_data)
    end

  end

end