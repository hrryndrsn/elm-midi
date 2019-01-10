module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (class, id)
import Task
import Time



-- MAIN


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Cell =
    { id : Int
    , sampleUrl : String
    }


type alias Row =
    { id : Int
    , sampleUrl : String
    , cells : List Cell
    }


type alias Model =
    { zone : Time.Zone
    , time : Time.Posix
    , beat : Int
    , rows : List Row
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Time.utc
        (Time.millisToPosix 0)
        0
        [ initRow 0 "kick"
        , initRow 1 "snare"
        , initRow 2 "base"
        , initRow 3 "shaker"
        ]
    , Task.perform AdjustTimeZone Time.here
    )


initRow : Int -> String -> Row
initRow index url =
    Row index
        url
        [ Cell 0 url
        , Cell 1 url
        , Cell 2 url
        , Cell 3 url
        , Cell 4 url
        , Cell 5 url
        , Cell 6 url
        , Cell 7 url
        , Cell 8 url
        , Cell 9 url
        , Cell 10 url
        , Cell 11 url
        , Cell 12 url
        , Cell 13 url
        , Cell 14 url
        , Cell 15 url
        ]



-- UPDATE


type Msg
    = Tick Time.Posix
    | AdjustTimeZone Time.Zone


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            let
                newBeat =
                    if model.beat < 15 then
                        model.beat + 1

                    else
                        0
            in
            ( { model
                | time = newTime
                , beat = newBeat
              }
            , Cmd.none
            )

        AdjustTimeZone newZone ->
            ( { model | zone = newZone }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 125 Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        hour =
            String.fromInt (Time.toHour model.zone model.time)

        minute =
            String.fromInt (Time.toMinute model.zone model.time)

        second =
            String.fromInt (Time.toSecond model.zone model.time)

        beat =
            String.fromInt model.beat
    in
    div [ class "container" ]
        [ h1 [] [ text (hour ++ ":" ++ minute ++ ":" ++ second) ]
        , h1 []
            [ text beat ]
        , renderRows model.rows model.beat
        ]


renderRows : List Row -> Int -> Html Msg
renderRows rows activeCell =
    div [] (List.map (\r -> renderRow r activeCell) rows)


renderRow : Row -> Int -> Html Msg
renderRow row activeCell =
    div [ class "row" ] (List.map (\c -> cell c activeCell) row.cells)


cell : Cell -> Int -> Html Msg
cell cl activeCell =
    div [ class (renderCellClass cl.id activeCell), id (String.fromInt <| cl.id) ] []


renderCellClass : Int -> Int -> String
renderCellClass index activeCell =
    if index == activeCell then
        "cell active"

    else
        "cell"
