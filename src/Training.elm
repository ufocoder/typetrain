module Training exposing (..)

import Html exposing (Attribute, Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Training.Data exposing (speed)
import Training.Keyboard
import Types exposing (..)


viewStatistic : Training -> Html Msg
viewStatistic training =
    div [ style "padding" "20px" ]
        [ div []
            [ text "count:", text (String.fromInt training.count) ]
        , div []
            [ text "timeout:", text (String.fromInt training.timeout) ]
        , div []
            [ text "speed:", text (String.fromFloat (speed training)) ]
        , div []
            [ text "pressedKeys: ", text (String.join ", " training.pressedKeys) ]
        ]


trainingTextStyle : List (Attribute msg)
trainingTextStyle =
    [ style "fext-align" "center"
    , style "font-size" "24"
    ]


viewTraintingText : Training -> Html Msg
viewTraintingText training =
    div trainingTextStyle
        [ text training.text
        ]


view : TrainingSession -> Html Msg
view session =
    case session of
        NotAsk ->
            div [ style "padding" "20px" ]
                [ button [ onClick TrainingTextRequest ] [ text "Get text" ]
                ]

        Loading ->
            div [ style "padding" "20px" ]
                [ text "Loading" ]

        Failure ->
            div [ style "padding" "20px" ]
                [ text "Error" ]

        Ready training ->
            div [ style "padding" "20px" ]
                [ div [ style "padding" "20px 0" ] [ text "Text:" ]
                , viewTraintingText training
                , viewStatistic training
                , Training.Keyboard.view training
                ]
