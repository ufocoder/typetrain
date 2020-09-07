module Types exposing (..)

import Http
import Time


type alias Training =
    { text : String
    , timeout : Int
    , cursor : Int
    , count : Int
    , lastKey : String
    , pressedKeys : List String
    }


type TrainingSession
    = NotAsk
    | Failure
    | Loading
    | Ready Training


type Page
    = HomePage
    | TrainingPage TrainingSession
    | ResultsPage Training


type alias Model =
    { page : Page
    }


type Msg
    = ChangePage Page
    | TrainingTextRequest
    | TrainingTextResponse (Result Http.Error String)
    | TrainingKeyUp String
    | TrainingKeyDown String
    | TrainingTick Time.Posix
