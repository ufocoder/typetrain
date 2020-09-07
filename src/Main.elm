module Main exposing (..)

import Browser
import Home
import Html exposing (Html)
import Results
import Training
import Training.Events
import Training.Remote
import Types exposing (..)



-- UPDATE


setPage : Page -> ( Model, Cmd Msg )
setPage page =
    ( { page = page }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePage page ->
            setPage page

        TrainingTextRequest ->
            Training.Remote.createTextRequest

        TrainingTextResponse result ->
            Training.Remote.processTextResponse result

        TrainingKeyUp keyCode ->
            Training.Events.processKeyUp keyCode model

        TrainingKeyDown keyCode ->
            Training.Events.processKeyDown keyCode model

        TrainingTick _ ->
            Training.Events.processTick model



-- SUBSCRIBTION


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.page of
        TrainingPage session ->
            case session of
                Ready training ->
                    Training.Events.subscriptions training

                _ ->
                    Sub.none

        _ ->
            Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    case model.page of
        HomePage ->
            Home.view model

        TrainingPage session ->
            Training.view session

        ResultsPage training ->
            Results.view training



-- MAIN


text : String
text =
    "Your first text"


init : ( Model, Cmd Msg )



-- init = ( { page = HomePage }, Cmd.none )


init =
    ( { page = TrainingPage (Ready (Training.Remote.createTraining text)) }, Cmd.none )


main =
    Browser.element
        { init = \() -> init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
