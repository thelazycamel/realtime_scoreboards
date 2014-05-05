module RealtimeScoreboards

  class Darts < RealtimeScoreboards::Scoreboard

    def properties
      [
          :eid,   :atype, :oid,   :bseg,
          :pts,   :tpts,  :lgst,  :secs,
          :clock, :ocre,  :es,    :p1,
          :p2,    :msg, :sid
      ]
    end

    def sid
      965300
    end

    def eid
      raw_json["Event"]["EventId"]
    end

    def atype
      raw_json["ActionTypeName"]
    end

    def oid
      raw_json["OpponentId"]
    end

    def bseg
      raw_json["BoardSegment"]
    end

    def pts
      raw_json["Points"]
    end

    def tpts
      raw_json["TotalPoints"]
    end

    def lgst
      [raw_json["Event"]["EventLength"]["Legs"], raw_json["Event"]["EventLength"]["Sets"]]
    end

    def secs
      raw_json["Event"]["ElapsedMatchSeconds"]
    end

    def clock
      raw_json["Event"]["IsClockRunning"]
    end

    def ocre
      raw_json["Event"]["IsPlayer1AtTheOche"]
    end

    def es
      raw_json["Event"]["EventStatus"]
    end

    def p1
      player("Player1")
    end

    def p2
      player("Player2")
    end

    def msg
      raw_json["ActionCommentary"]
    end

    private

    def player(player_id)
      player = raw_json["Event"][player_id]
      {
        :oid => player["OpponentId"],
        :nam => player["Name"],
        :sets => player["Score"]["Sets"],
        :legs => player["Score"]["Legs"],
        :pts => player["Score"]["Points"],
        :avg => player["Stats"]["ThreeDartAverage"],
        :cos => [
          player["Stats"]["Checkouts"]["Green"],
          player["Stats"]["Checkouts"]["Red"],
          player["Stats"]["Checkouts"]["Maximum"]
        ],
        :stats => [
          player["Stats"]["NumberOf100plus"],
          player["Stats"]["NumberOf140plus"],
          player["Stats"]["NumberOf180s"]
          
          
        ]
      }
    end

  end
end