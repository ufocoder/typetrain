module Results exposing (view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Training.Data exposing (isTrainingSuccess)
import Types exposing (..)


view : Training -> Html Msg
view training =
    div [ style "padding" "20px" ]
        [ div []
            [ text "count:", text (String.fromInt training.count) ]
        , div []
            [ text
                ("success:"
                    ++ (if isTrainingSuccess training then
                            "yes"

                        else
                            "no"
                       )
                )
            ]
        ]
