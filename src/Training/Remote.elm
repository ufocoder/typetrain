module Training.Remote exposing (..)

import Http
import Types exposing (..)


url : String
url =
    "https://litipsum.com/api/1"


getRemoteText : Cmd Msg
getRemoteText =
    Http.get
        { url = url
        , expect = Http.expectString TrainingTextResponse
        }


createTextRequest : ( Model, Cmd Msg )
createTextRequest =
    ( { page = TrainingPage Loading }, getRemoteText )


createTraining : String -> Training
createTraining text =
    { count = 0
    , timeout = 0
    , cursor = 0
    , lastKey = ""
    , text = text
    , pressedKeys = []
    }


processTextResponse : Result Http.Error String -> ( Model, Cmd Msg )
processTextResponse result =
    case result of
        Ok dataStr ->
            ( { page = TrainingPage (Ready (createTraining dataStr)) }, Cmd.none )

        Err _ ->
            ( { page = TrainingPage Failure }, Cmd.none )
