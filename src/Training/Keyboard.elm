module Training.Keyboard exposing (..)

import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (style)
import Types exposing (..)


keyboardBaseStyle : List (Attribute msg)
keyboardBaseStyle =
    [ style "padding" "20px"
    , style "background-color" "rgb(197, 197, 197)"
    , style "border-radius" "10px"
    , style "display" "grid"
    , style "grid-template-columns" "repeat(30, 30px)"
    , style "grid-template-rows" "repeat(5, 60px)"
    , style "grid-gap" "5px"
    ]


keyboardKeyStyle : List (Attribute msg)
keyboardKeyStyle =
    [ style "background-color" "rgb(243, 243, 243)"
    , style "border" "2px solid #333"
    , style "border-radius" "5px"
    , style "grid-column" "span 2"
    , style "font-size" "20px"
    , style "text-align" "center"
    , style "padding-top" "17px"
    ]


keyboardKeyPressedStyle : List (Attribute msg)
keyboardKeyPressedStyle =
    keyboardKeyStyle
        ++ [ style "border" "2px solid #000"
           , style "background-color" "#ccc"
           ]


layout =
    [
        []
    ]

-- 12 * 1 + 1 * 1.5
-- 1 * 1.5 12 * 

wasd =
    [ ( "~", "" )
    , ( "1", "" )
    , ( "2", "" )
    , ( "3", "" )
    , ( "4", "" )
    , ( "5", "" )
    , ( "6", "" )
    , ( "7", "" )
    , ( "8", "" )
    , ( "9", "" )
    , ( "0", "" )
    , ( "-", "" )
    , ( "+", "" )
    , ( "Delete", "delete" )
    , ( "Tab", "tab" )
    , ( "q", "" )
    , ( "w", "" )
    , ( "e", "" )
    , ( "r", "" )
    , ( "t", "" )
    , ( "y", "" )
    , ( "u", "" )
    , ( "i", "" )
    , ( "o", "" )
    , ( "P", "" )
    , ( "[", "" )
    , ( "]", "" )
    , ( "\\", "backslash" )
    , ( "CapsLock", "capslock" )
    , ( "A", "" )
    , ( "S", "" )
    , ( "D", "" )
    , ( "F", "" )
    , ( "G", "" )
    , ( "H", "" )
    , ( "J", "" )
    , ( "K", "" )
    , ( "L", "" )
    , ( ";", "" )
    , ( "'", "" )
    , ( "Return", "return" )
    , ( "Shift", "leftshift" )
    , ( "Z", "" )
    , ( "X", "" )
    , ( "C", "" )
    , ( "V", "" )
    , ( "B", "" )
    , ( "N", "" )
    , ( "M", "" )
    , ( ",", "" )
    , ( ".", "" )
    , ( "/", "" )
    , ( "Shift", "rightshift" )
    , ( "Ctrl", "leftctrl" )
    , ( "Alt", "\"" )
    , ( "command", "Command" )
    , ( "space", "Space" )
    , ( "command", "command" )
    , ( "Alt", "" )
    , ( "Ctrl", "" )
    , ( "Fn", "" )
    ]


keyboardKeys : Training -> List (Html Msg)
keyboardKeys training =
    let
        renderKey =
            \( key, extraClass ) ->
                let
                    isKeyPressed =
                        List.member key training.pressedKeys

                    styles =
                        if isKeyPressed then
                            keyboardKeyPressedStyle

                        else
                            keyboardKeyStyle
                in
                div styles [ text key ]
    in
    List.map renderKey wasd


view : Training -> Html Msg
view training =
    div keyboardBaseStyle
        (keyboardKeys training)
