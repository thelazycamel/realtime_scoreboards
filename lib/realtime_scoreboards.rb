module RealtimeScoreboards


  require "vertx"

  require "#{File.dirname(__FILE__)}/realtime_scoreboards/config"
  require "#{File.dirname(__FILE__)}/realtime_scoreboards/listener"
  require "#{File.dirname(__FILE__)}/realtime_scoreboards/push_server"
  require "#{File.dirname(__FILE__)}/realtime_scoreboards/scoreboard"
  require "#{File.dirname(__FILE__)}/realtime_scoreboards/scoreboards/darts.rb"
  require "#{File.dirname(__FILE__)}/realtime_scoreboards/scoreboards/horse_racing.rb"
  require "#{File.dirname(__FILE__)}/realtime_scoreboards/scoreboards/football.rb"
  require "#{File.dirname(__FILE__)}/realtime_scoreboards/start_servers"

end