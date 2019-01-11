port module Main exposing (Model, Msg(..), init, main, playSound, subscriptions, update, view)

import Array
import Browser
import Html exposing (..)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Json.Decode as Decode
import Json.Encode as E
import Task
import Time



-- port out


port playSound : String -> Cmd msg



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
    , armed : Bool
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
    , counter : Int
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
        0
    , Task.perform AdjustTimeZone Time.here
    )


initRow : Int -> String -> Row
initRow index url =
    Row index
        url
        [ Cell 0 url False
        , Cell 1 url False
        , Cell 2 url False
        , Cell 3 url False
        , Cell 4 url False
        , Cell 5 url False
        , Cell 6 url False
        , Cell 7 url False
        , Cell 8 url False
        , Cell 9 url False
        , Cell 10 url False
        , Cell 11 url False
        , Cell 12 url False
        , Cell 13 url False
        , Cell 14 url False
        , Cell 15 url False
        ]



-- UPDATE


type Msg
    = Tick Time.Posix
    | AdjustTimeZone Time.Zone
    | SendPlaySound (List String)
    | ArmCell Int Int


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

                chckrws =
                    checkRows model.rows model.beat
            in
            case List.isEmpty chckrws of
                True ->
                    ( { model
                        | time = newTime
                        , beat = newBeat
                      }
                    , Cmd.none
                    )

                False ->
                    let
                        enc =
                            E.encode 0 (E.list E.string chckrws)
                    in
                    ( { model
                        | time = newTime
                        , beat = newBeat
                      }
                    , playSound enc
                    )

        SendPlaySound list ->
            let
                arr =
                    Array.fromList list

                enc =
                    E.encode 0 (E.list E.string list)
            in
            ( model
            , playSound enc
            )

        AdjustTimeZone newZone ->
            ( { model | zone = newZone }
            , Cmd.none
            )

        ArmCell rowId cellId ->
            let
                rowArr =
                    Array.fromList model.rows

                ri =
                    Array.get rowId rowArr

                xri =
                    case ri of
                        Just a ->
                            a

                        Nothing ->
                            Row -1 "" []

                cellArr =
                    Array.fromList xri.cells

                ci =
                    Array.get cellId cellArr

                xci =
                    case ci of
                        Just a ->
                            a

                        Nothing ->
                            Cell -1 "" False

                armed =
                    case xci.armed of
                        True ->
                            { xci | armed = False }

                        False ->
                            { xci | armed = True }

                updatedCellArr =
                    Array.set cellId armed cellArr

                updatedRi =
                    { xri | cells = Array.toList updatedCellArr }

                updatedRowArr =
                    Array.set rowId updatedRi rowArr
                        |> Array.toList
            in
            ( { model | rows = updatedRowArr }
            , Cmd.none
            )


firePlaySound : String -> Cmd msg
firePlaySound str =
    playSound str


checkRows : List Row -> Int -> List String
checkRows rows beat =
    let
        mapped =
            List.map (\row -> checkRow row beat) rows

        toPlay =
            []

        folded =
            List.map
                (\li ->
                    let
                        list =
                            List.map (\row -> row.sampleUrl :: toPlay) li
                    in
                    list ++ toPlay
                )
                mapped

        filtered =
            List.filter
                (\li ->
                    List.isEmpty li == not True
                )
                mapped

        flist =
            flatten2D filtered

        justSample =
            List.map
                (\c ->
                    c.sampleUrl
                )
                flist
    in
    justSample


flatten2D : List (List a) -> List a
flatten2D list =
    List.foldr (++) [] list


checkRow : Row -> Int -> List Cell
checkRow row beat =
    let
        playing =
            List.filter
                (\ce ->
                    ce.id == beat
                )
                row.cells

        armed =
            List.filter
                (\ce ->
                    ce.armed == True
                )
                playing
    in
    armed


checkCell : Cell -> Int -> Maybe String
checkCell c beat =
    if c.id == beat then
        Just c.sampleUrl

    else
        Nothing


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
    div [ class "row" ] (List.map (\c -> cell row.id c activeCell) row.cells)


cell : Int -> Cell -> Int -> Html Msg
cell rowId cl activeCell =
    div
        [ class (renderCellClass cl.id activeCell cl.armed)
        , id (String.fromInt <| cl.id)
        , onClick (ArmCell rowId cl.id)
        ]
        []


renderCellClass : Int -> Int -> Bool -> String
renderCellClass index activeCell armed =
    if armed == True then
        "cell armed"

    else if index == activeCell then
        "cell active"

    else
        "cell"
