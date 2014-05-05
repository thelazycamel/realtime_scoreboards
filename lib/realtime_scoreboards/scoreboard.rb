module RealtimeScoreboards

  class Scoreboard

    include Vertx

    attr_reader :raw_json, :event_id, :payload, :properties

    @@TYPES = {
      "22886" => "Darts",
      "240"   => "Football",
      "364"   => "HorseRacing"
    }

    def initialize(json_data)
      @raw_json = data_to_json(json_data)
      @payload = parse_json
    end

    def properties
      []
    end

    def self.new_scoreboard_instance(sport_id, payload)
      klass = @@TYPES[sport_id] || "Scoreboard"
      RealtimeScoreboards.const_get(klass).new(payload)
    rescue
      RealtimeScoreboards::Scoreboard.new(payload)
    end

    def push
      puts "receiving data for #{event_id}"
      EventBus.send("scoreboards_en_#{event_id}", payload)
    end

    def event_id
      @event_id ||= payload["EventActionSite"]["e"]["eid"] rescue 0
    end

    def new_payload
      Hash[properties.map {|prop| [prop, self.send(prop)] }]
    end

    def data_to_json(json_data)
      JSON.parse(json_data)
    end

    def parse_json
      properties.empty? ? @raw_json : new_payload
    end

  end

end