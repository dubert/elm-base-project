module Main exposing (main)

import Html
import Navigation exposing (Location)
import App exposing (init, update, view, Msg(..), urlParser)


main =
    Navigation.program
        navigationHandler
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }



--


navigationHandler : Location -> Msg
navigationHandler =
    urlParser >> Set
