module Training.Events exposing (..)

import Browser.Events
import Json.Decode as Decode
import Time
import Training.Data exposing (isTrainingOver)
import Types exposing (..)


keyDownToAction : String -> Msg
keyDownToAction key =
    TrainingKeyDown key


keyDownDecoder : Decode.Decoder Msg
keyDownDecoder =
    Decode.map keyDownToAction (Decode.field "key" Decode.string)


keyUpToAction : String -> Msg
keyUpToAction key =
    TrainingKeyUp key


keyUpDecoder : Decode.Decoder Msg
keyUpDecoder =
    Decode.map keyUpToAction (Decode.field "key" Decode.string)


subscriptions : Training -> Sub Msg
subscriptions training =
    let
        keyboardSubscriptions =
            [ Browser.Events.onKeyDown keyDownDecoder
            , Browser.Events.onKeyUp keyUpDecoder
            ]
    in
    if training.cursor > 0 then
        Sub.batch (keyboardSubscriptions ++ [ Time.every 1000 TrainingTick ])

    else
        Sub.batch keyboardSubscriptions


processKeyDown : String -> Model -> ( Model, Cmd Msg )
processKeyDown keyCode model =
    case model.page of
        TrainingPage (Ready training) ->
            if List.member keyCode training.pressedKeys then
                ( model, Cmd.none )

            else
                let
                    nextChar =
                        String.slice training.cursor (training.cursor + 1) training.text

                    newCursor =
                        if nextChar == keyCode then
                            training.cursor + 1

                        else
                            training.cursor

                    newTraining =
                        { training
                            | count = training.count + 1
                            , lastKey = keyCode
                            , cursor = newCursor
                            , pressedKeys = keyCode :: training.pressedKeys
                        }
                in
                if newCursor == String.length training.text then
                    ( { page = ResultsPage newTraining }, Cmd.none )

                else
                    ( { page = TrainingPage (Ready newTraining) }, Cmd.none )

        _ ->
            ( model, Cmd.none )


processKeyUp : String -> Model -> ( Model, Cmd Msg )
processKeyUp keyCode model =
    case model.page of
        TrainingPage (Ready training) ->
            let
                hasPressedKeyCode =
                    \pressedKey -> not (pressedKey == keyCode)

                newTraining =
                    { training
                        | pressedKeys = List.filter hasPressedKeyCode training.pressedKeys
                    }
            in
            ( { page = TrainingPage (Ready newTraining) }, Cmd.none )

        _ ->
            ( model, Cmd.none )


processTick : Model -> ( Model, Cmd Msg )
processTick model =
    case model.page of
        TrainingPage (Ready training) ->
            let
                newTimeout =
                    training.timeout + 1

                newTraining =
                    { training | timeout = newTimeout }
            in
            if isTrainingOver newTraining then
                ( { page = TrainingPage (Ready newTraining) }, Cmd.none )

            else
                ( { page = ResultsPage newTraining }, Cmd.none )

        _ ->
            ( model, Cmd.none )
