module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Navigation exposing (..)
import UrlParser exposing ((</>), s, int, string, parseHash)


type alias Model =
    Int


init : Location -> ( Model, Cmd Msg )
init l =
    ( urlParser l, Cmd.none )


urlParser : Location -> Int
urlParser l =
    UrlParser.parsePath UrlParser.int l
        |> Maybe.withDefault 0



-- UPDATE


type Msg
    = Inc
    | Set Int


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Inc ->
            ( model, Navigation.newUrl <| toString (model + 1) )

        Set val ->
            ( val, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 []
            [ img [ src "images/logo.png" ] []
            , text "Hot loading"
            ]
        , p [] [ text "Click on the button below to increment the state." ]
        , div []
            [ button
                [ class "btn btn-primary"
                , onClick Inc
                ]
                [ text "+ 1" ]
            , text <| toString model
            ]
        , p [] [ text "Then make a change to the source code and see how the state is retained after you recompile." ]
        , p []
            [ text "And now don't forget to add a star to the Github repo "
            , a [ href "https://github.com/simonh1000/elm-webpack-starter" ] [ text "elm-webpack-starter" ]
            ]
        ]
