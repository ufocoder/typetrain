module Home exposing (..)

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Types exposing (..)


view : Model -> Html Msg
view _ =
    let
        page =
            TrainingPage NotAsk
    in
    div [ style "padding" "20px" ]
        [ button [ onClick (ChangePage page) ] [ text "Train" ] ]
