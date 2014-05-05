module RealtimeScoreboards

  class PushServer

    include Vertx

    attr_reader :server, :sock_server, :host, :port, :prefix, :bridge_incoming, :bridge_outgoing

    def initialize(config)
      @connected_clients = []
      @server = HttpServer.new
      @sock_server = SockJSServer.new(server)
      @prefix = {'prefix' => config[:prefix]}
      @host = config[:host]
      @port = config[:port]
      @bridge_incoming = config[:bridge_incoming]
      @bridge_outgoing = config[:bridge_outgoing]
      register_handler
    end

    def listen
      sock_server.bridge(prefix, bridge_incoming, bridge_outgoing)
      server.listen(port, host) {puts "eventBus pushing on #{host}:#{port}"}
    end

    def register_handler
      bob = Vertx::EventBus.register_handler("scoreboards_en_240011200") do |message|
        #puts handler here
      end
    end


  end

end