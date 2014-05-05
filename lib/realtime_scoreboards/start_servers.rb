listener = RealtimeScoreboards::Listener.new(LISTENER_CONFIG).listen
sock_server = RealtimeScoreboards::PushServer.new(PUSH_CONFIG).listen