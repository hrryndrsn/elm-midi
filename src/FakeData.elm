module FakeData exposing (fakeData)


type alias Cell =
    { id : Int
    , sampleUrl : String
    }


type alias Row =
    { id : Int
    , sampleUrl : String
    , cells : List Cell
    }


fakeData : List Row
fakeData =
    [ { id = 0
      , sampleUrl = "snare"
      , cells =
            [ { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            , { id = 0, sampleUrl = "kick" }
            ]
      }
    , { id = 0
      , sampleUrl = "snare"
      , cells =
            [ { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            , { id = 0, sampleUrl = "snare" }
            ]
      }
    , { id = 0
      , sampleUrl = "vocal"
      , cells =
            [ { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            , { id = 0, sampleUrl = "vocal" }
            ]
      }
    ]
