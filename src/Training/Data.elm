module Training.Data exposing (..)

import Types exposing (Training)


time_limit: Int
time_limit =
    90


speed : Training -> Float
speed training =
    if toFloat training.cursor > 0 then
        (toFloat training.cursor / toFloat training.timeout) * 60

    else
        0


isTrainingSuccess : Training -> Bool
isTrainingSuccess training =
    training.cursor >= String.length training.text


isTrainingOver : Training -> Bool
isTrainingOver training =
    training.timeout < time_limit
